//
//  TransactionsList.swift
//  bonsai
//
//  Created by hoang on 08.12.2021.
//

import OrderedCollections
import SwiftUI

struct TransactionsList: View {
    
    enum kind { case all, budget }
    let kind: kind
    @State private var isOperationPresented = false

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
    var transactions: FetchedResults<Transaction>
    
    @FetchRequest(sortDescriptors: [])
    private var budgets: FetchedResults<Budget>
    private var budget: Budget? { budgets.first }
    #warning("change list of transaction in current selected budget ")
    
    var allowedTransactions: any Sequence<Transaction> {
        switch self.kind {
        case .all:
            return transactions
        case .budget:
            if let budget {
                return transactions.onlyFromBudget(budget)
            }
            return transactions
        }
    }
    
    func sortedTransactions() -> OrderedDictionary<String, [Transaction]> {
        var result = allowedTransactions
            .reduce(into: OrderedDictionary<String, [Transaction]>()) { partialResult, transaction in
                let date = transaction.date.dateString()
                if var arr = partialResult[date] {
                    arr.append(transaction)
                    partialResult[date] = arr
                } else {
                    partialResult[date] = [transaction]
                }
            }
        result.sort {
            if $0.key == "date.today" {
                return true
            }
            return $0.key > $1.key
        }
        return result
    }
    
    @Binding var isPresented: Bool
    @State var isTransactionDetailsPresented: Bool = false
    @State var selectedTransaction: Transaction?
    
    private var createPlaceholderForEmptyTransactions: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 12) {
                    Group {
                        Text("you_dont_have_a_transactions_history_yet")
                            .foregroundColor(.white)
                            .font(BonsaiFont.title_20)
                            .multilineTextAlignment(.center)
                        Button {
                            isOperationPresented = true
                        } label: {
                            Text("create_transactions")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }.padding(16)
                }
                Spacer()
            }
            Spacer()
        }
    }

    
    func sectionView(key: String, sum: NSDecimalNumber) -> some View {
        HStack {
            Text(LocalizedStringKey(key))
            Spacer()
            if sum < .zero {
                Text("\(sum.absValue) \(Currency.Validated.current.symbol)")
                    .font(BonsaiFont.title_headline_17)
                    .foregroundColor(BonsaiColor.green)
            } else {
                Text("-\(sum) \(Currency.Validated.current.symbol)")
                    .font(BonsaiFont.title_headline_17)
                    .foregroundColor(BonsaiColor.secondary)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            BudgetTransactionHeader()
                .contentShape(Rectangle())
                .padding(.vertical)
            if sortedTransactions().elements.isEmpty {
                createPlaceholderForEmptyTransactions
            } else {
                
                List {
                    ForEach(sortedTransactions().elements, id: \.key) { element in
                        let sum = element.value.reduce(NSDecimalNumber.zero) { partialResult, transaction in
                            if transaction.type == .income {
                                return partialResult.subtracting(transaction.amount)
                            } else {
                                return partialResult.adding(transaction.amount)
                            }
                        }
                        Section(header: sectionView(key: element.key, sum: sum)
                            .font(BonsaiFont.body_15)
                            .foregroundColor(Color.white)
                        ) {
                            ForEach(element.value) { transaction in
                                TransactionCell(model: .init(transaction: transaction))
                                    .onTapGesture(perform: {
                                        selectedTransaction = transaction
                                        isTransactionDetailsPresented = true
                                    })
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            } // ForEach
                        } // Section
                    } // ForEach
                } // ScrollView
            }
        }
        .listStyle(.plain)
        .fullScreenCover(isPresented: $isTransactionDetailsPresented) { [selectedTransaction] in
            OperationDetails(
                isPresented: $isTransactionDetailsPresented,
                transaction: selectedTransaction
            )
        }
        .fullScreenCover(isPresented: $isOperationPresented) {
            OperationDetails(isPresented: $isOperationPresented)
        }
    }
}

struct TransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsList(kind: .all, isPresented: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}

extension NSDecimalNumber {
    var absValue: Self {
        .init(decimal: decimalValue.magnitude)
    }
}
