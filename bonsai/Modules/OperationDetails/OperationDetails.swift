//
//  OperationDetails.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI
import OrderedCollections

struct OperationDetails: View {

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
    @FetchRequest(sortDescriptors: [])
    private var fetchedTransactions: FetchedResults<Transaction>
    
    private let iconSizeSide: CGFloat = 20

    @Namespace private var calendarID

    enum Field {
        case amount
        case title
    }
    @FocusState private var focusedField: Field?
    @State var isDeleteConfirmationPresented = false
    @Environment(\.dismiss) var dismiss

    func removeTransactionButton() -> some View {
        Button(LocalizedStringKey("transaction.delete.button")) {
            isDeleteConfirmationPresented = true
        }
        .foregroundColor(.red)
        .opacity(0.8)
        .confirmationDialog(
            LocalizedStringKey("delete_transaction_Confirmation"),
            isPresented: $isDeleteConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button(LocalizedStringKey("transaction.delete.confirmation"), role: .destructive) {
                if case .edit(let transaction) = kind {
                    moc.delete(transaction)
                    do {
                        try moc.save()
                    } catch (let e) {
                        assertionFailure(e.localizedDescription)
                    }
                    dismiss()
                   
                }
            }
            Button(LocalizedStringKey("Cancel_title"), role: .cancel) {
                isDeleteConfirmationPresented = false
            }
        }
    }

    init(isPresented: Binding<Bool>, transaction: Transaction? = nil) {
        self._isPresented = isPresented
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
                ScrollViewReader { reader in
                    VStack(spacing: 0) {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .center, spacing: 0) {
                                OperationTypeSelectorView(
                                    operations: [.expense, .income],
                                    selectedOperation: $selectedOperation
                                )
                                AmountView(
                                    amountTitle: "operation.amount",
                                    operation: selectedOperation,
                                    currency: currency,
                                    text: $amount
                                )
                                .focused($focusedField, equals: .amount)
                                .cornerRadius(13)
                                .padding([.top], 16)
                                CategoryView(
                                    category: $category,
                                    iconSizeSide: 24
                                )
                                .cornerRadius(13, corners: [.topLeft, .topRight])
                                .padding([.top], 16)
                                .onTapGesture {
                                    focusedField = nil
                                    isCategoriesViewPresented = true
                                }
                                ZStack { // separator
                                    BonsaiColor.card
                                        .frame(height: 1)
                                    BonsaiColor.separator
                                        .frame(height: 1)
                                        .padding([.leading, .trailing], 16)
                                }
                                TitleView(title: "operation.title", image: BonsaiImage.textBubble, text: $title)
                                    .cornerRadius(13, corners: [.bottomLeft, .bottomRight])
                                    .focused($focusedField, equals: .title)
                                TagsInputView(
                                    tags: $tags,
                                    newTagHandler: {
                                        focusedField = nil
                                        isTagsViewPresented = true
                                    }
                                )
                                .cornerRadius(13)
                                .padding(.top, 16)
                                DateSelectorView(
                                    date: $date,
                                    fullSized: $isCalendarOpened,
                                    isClosedRange: true
                                )
                                .cornerRadius(13)
                                .padding(.top, 16)
                                .id(calendarID)
                                
                                if case .edit = kind {
                                    removeTransactionButton()
                                        .padding(20)
                                }
                             
                            } // VStack
                            .padding([.top, .leading, .trailing, .bottom], 16)
                            .onChange(of: isCalendarOpened) { newValue in
                                guard newValue == true else { return }
                                focusedField = nil
                                withAnimation {
                                    reader.scrollTo(calendarID)
                                } // withAnimation
                            } // onChange
                        } // ScrollView
                        Button {
                            switch kind {
                            case .new:
                                do {
                                    bonsai.Transaction(
                                        context: moc,
                                        amount: NSDecimalNumber(string: amount),
                                        title: title,
                                        date: date,
                                        category: category,
                                        account: try moc.fetch(Account.fetchRequest())
                                            .first ?? Account(
                                                context: moc,
                                                title: "Default"
                                            ),
                                        type: selectedOperation.mappedToTransactionType,
                                        tags: Set(tags),
                                        currency: currency
                                    )

                                    try moc.save()
                                    isPresented = false
                                } catch (let e) {
                                    assertionFailure(e.localizedDescription)
                                }
                            case .edit(let transaction):
                                let request = Transaction.fetchRequest()
                                request.predicate = .init(format: "transactionId == %@", transaction.transactionId as CVarArg)
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
                            Text(LocalizedStringKey("Save_title"))
                        } // Button
                        .buttonStyle(PrimaryButtonStyle())
                        .padding([.top, .bottom], 12)
                        .disabled(amount.isEmpty)
                    } // VStack
                } // ScrollViewReader
            } // ZStack
            .navigationTitle(LocalizedStringKey(kind == .new ? "operation.new" : "operation.edit"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        focusedField = nil
                        isPresented = false
                    }) {
                        Text(LocalizedStringKey("Cancel_title"))
                            .foregroundColor(BonsaiColor.secondary)
                    }
                }
            }
        } // NavigationView
        .fullScreenCover(isPresented: $isCategoriesViewPresented) {
            CategoriesContainerView(
                selectedCategory: $category,
                isPresented: $isCategoriesViewPresented
            )
        }
        .fullScreenCover(isPresented: $isTagsViewPresented) {
            TagsContainerView(
                selectedTags: $tags,
                isPresented: $isTagsViewPresented
            )
        }
        .interactiveDismissDisabled(kind == .new)
    }
}

struct OperationDetails_Previews: PreviewProvider {
    static var previews: some View {
        OperationDetails(isPresented: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
