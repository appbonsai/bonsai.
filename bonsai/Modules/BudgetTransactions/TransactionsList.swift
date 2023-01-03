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
            $0.key > $1.key
        }
        return result
    }
    
    @Binding var isPresented: Bool
    @State var isTransactionDetailsPresented: Bool = false
    @State var selectedTransaction: Transaction?
    
    func sectionView(key: String, sum: NSDecimalNumber) -> some View {
        HStack {
            Text(LocalizedStringKey(key))
            Spacer()
            Text(LocalizedStringKey(String(describing: sum)))
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            BudgetTransactionHeader()
                .contentShape(Rectangle())
                .padding(.vertical)
            List {
                ForEach(sortedTransactions().elements, id: \.key) { element in
                    let sum = element.value.reduce(NSDecimalNumber.zero) { partialResult, transaction in
                        if transaction.type == .income {
                            return transaction.amount.subtracting(partialResult)
                        } else {
                            return transaction.amount.adding(partialResult)
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
        .listStyle(.plain)
        .fullScreenCover(isPresented: $isTransactionDetailsPresented) { [selectedTransaction] in
            OperationDetails(
                isPresented: $isTransactionDetailsPresented,
                transaction: selectedTransaction
            )
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
