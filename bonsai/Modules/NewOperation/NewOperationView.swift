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

   @Binding var isPresented: Bool

   @State var selectedOperation: OperationType = .expense
   @State var amount: String = ""
   @State var currency: Currency.Validated = .current
   @State var category: Category?
   @State var title: String = ""
   @State var tags: OrderedSet<Tag> = []
   @State var date: Date = Date()
   @State var isCategoriesViewPresented: Bool = false
   @State var isTagsViewPresented: Bool = false
   @State var isCalendarOpened: Bool = false
   @State private var confirmationPresented: Bool = false

   let iconSizeSide: CGFloat = 20

   @Namespace var calendarID

   init(isPresented: Binding<Bool>) {
      self._isPresented = isPresented
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
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
               } label: {
                  Text("Save")
               }
               .buttonStyle(PrimaryButtonStyle())
               .padding([.top], 16)
               .disabled(amount.isEmpty)
            } // VStack
         } // ZStack
         .navigationTitle("New Operation")
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
