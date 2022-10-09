//
//  NewOperationView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI
import OrderedCollections

struct NewOperationView: View {

   @Environment(\.managedObjectContext) private var moc

   @Binding private var isPresented: Bool

   enum Kind: Equatable {
      case new
      case edit(Transaction)
   }
   private let kind: Kind

   @State private var selectedOperation: OperationType
   @State private var amount: String
   @State private var currency: Currency.Validated
   @State private var category: Category?
   @State private var title: String
   @State private var tags: OrderedSet<Tag>
   @State private var date: Date

   @State private var isCategoriesViewPresented: Bool = false
   @State private var isTagsViewPresented: Bool = false
   @State private var isCalendarOpened: Bool = false
   @State private var confirmationPresented: Bool = false

   private let iconSizeSide: CGFloat = 20

   @Namespace private var calendarID

   init(isPresented: Binding<Bool>, transaction: Transaction? = nil) {
      self._isPresented = isPresented
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      if let transaction = transaction {
         self.kind = .edit(transaction)
         self._selectedOperation = .init(
            initialValue: .init(transactionType: transaction.type)
         )
         self._amount = .init(
            initialValue: transaction.amount.stringValue
         )
         self._currency = .init(initialValue: transaction.currency)
         self._category = .init(initialValue: transaction.category)
         self._title = .init(initialValue: transaction.title ?? "")
         self._tags = .init(initialValue: OrderedSet(transaction.tags))
         self._date = .init(initialValue: transaction.date)
      } else {
         self.kind = .new
         self._selectedOperation = .init(initialValue: .expense)
         self._amount = .init(initialValue: "")
         self._currency = .init(initialValue: .current)
         self._category = .init(initialValue: nil)
         self._title = .init(initialValue: "")
         self._tags = .init(initialValue: [])
         self._date = .init(initialValue: Date())
      }
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            VStack {
               ScrollViewReader { reader in
                  ScrollView(.vertical, showsIndicators: false) {
                     VStack(alignment: .center, spacing: 0) {
                        OperationTypeSelectorView(
                           operations: [.expense, .income],
                           selectedOperation: $selectedOperation
                        )
                        .padding([.bottom], 12)
                        AmountView(
                           operation: selectedOperation,
                           currency: currency,
                           text: $amount
                        )
                        .cornerRadius(13)
                        .padding([.top], 12)
                        CategoryView(category: $category, iconSizeSide: 24)
                           .cornerRadius(13, corners: [.topLeft, .topRight])
                           .padding([.top], 16)
                           .onTapGesture {
                              isCategoriesViewPresented = true
                           }
                        ZStack { // separator
                           BonsaiColor.card
                              .frame(height: 1)
                           BonsaiColor.separator
                              .frame(height: 1)
                              .padding([.leading, .trailing], 16)
                        }
                        TitleView(text: $title)
                           .cornerRadius(13, corners: [.bottomLeft, .bottomRight])
                        TagsInputView(
                           tags: $tags,
                           newTagHandler: { isTagsViewPresented = true }
                        )
                        .cornerRadius(13)
                        .padding([.top], 16)
                        DateSelectorView(date: $date, fullSized: $isCalendarOpened)
                           .cornerRadius(13)
                           .padding([.top], 16)
                           .id(calendarID)
                     } // VStack
                     .padding([.top, .leading, .trailing], 16)
                     .onChange(of: isCalendarOpened) { newValue in
                        guard newValue == true else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                           withAnimation {
                              reader.scrollTo(calendarID)
                           }
                        }
                     }
                  } // ScrollView
               } // ScrollViewReader
               Button {
                  switch kind {
                  case .new:
                     bonsai.Transaction(
                        context: moc,
                        amount: NSDecimalNumber(string: amount),
                        title: title,
                        date: date,
                        category: category ?? .notSpecified,
                        account: .default,
                        type: selectedOperation.mappedToTransactionType,
                        tags: Set(tags),
                        currency: currency
                     )
                     do {
                        try moc.save()
                        isPresented = false
                     } catch (let e) {
                        assertionFailure(e.localizedDescription)
                     }
                  case .edit(let transaction):
                     let request = Transaction.fetchRequest()
                     request.predicate = .init(format: "id == %@", transaction.id as CVarArg)
                     do {
                        guard let result = try moc.fetch(request).first else {
                           assertionFailure("Transaction with id \(transaction.id) not found")
                           isPresented = false
                           return
                        }
                        result.update(
                           amount: NSDecimalNumber(string: amount),
                           title: title,
                           date: date,
                           category: category,
                           type: selectedOperation.mappedToTransactionType,
                           tags: Set(tags),
                           currency: currency
                        )
                        try moc.save()
                        isPresented = false
                     } catch (let e) {
                        assertionFailure(e.localizedDescription)
                     }
                  }
               } label: {
                  Text("Save")
               } // Button
               .buttonStyle(PrimaryButtonStyle())
               .padding([.top], 16)
               .disabled(amount.isEmpty)
            } // VStack
         } // ZStack
         .navigationTitle(kind == .new ? "New Operation" : "Edit Operation")
         .navigationBarTitleDisplayMode(.large)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               Button(action: {
                  confirmationPresented = true
               }) {
                  Text("Cancel")
                     .foregroundColor(BonsaiColor.secondary)
               }
               // TODO: Localize
               .confirmationDialog("Are you sure?", isPresented: $confirmationPresented, actions: {
                  Button("Discard Transaction", role: .destructive, action: {
                     isPresented = false
                  })
               })
            }
         }
      } // NavigationView
      .popover(isPresented: $isCategoriesViewPresented) {
         CategoriesContainerView(
            isPresented: $isCategoriesViewPresented,
            selectedCategory: $category
         )
      }
      .popover(isPresented: $isTagsViewPresented) {
         TagsContainerView(
            isPresented: $isTagsViewPresented,
            selectedTags: $tags
         )
      }
   }
}

struct NewOperationView_Previews: PreviewProvider {
   static var previews: some View {
      NewOperationView(isPresented: .constant(true))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
