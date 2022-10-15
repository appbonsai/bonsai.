//
//  BudgetTransactions.swift
//  bonsai
//
//  Created by hoang on 08.12.2021.
//
import OrderedCollections
import SwiftUI

struct VisualEffectView: UIViewRepresentable {
   var effect: UIVisualEffect?
   func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
   func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct BudgetTransactions: View {

   private let transactionsByDate: OrderedDictionary<String, [Transaction]>
   @Binding var isPresented: Bool

   init(transactions: [Transaction], isPresented: Binding<Bool>) {
      self._isPresented = isPresented
      var dict = OrderedDictionary<String, [Transaction]>()
      let sortedTransaction = transactions
         .sorted(by: { $0.date > $1.date  })
      for transaction in sortedTransaction {
            let date = transaction.date.dateString()
            if var arr = dict[date] {
               arr.append(transaction)
               dict[date] = arr
            } else {
               dict[date] = [transaction]
            }
      }
      transactionsByDate = dict
   }
    
    private func transactionsByDateList() -> some View {
        ScrollView(showsIndicators: false) {
            ForEach(transactionsByDate.keys, id: \.self) { key in
                Section(header: HStack() {
                    Spacer()
                    Text("\(key)")
                        .font(BonsaiFont.body_15)
                        .foregroundColor(Color.white)
                    Spacer()
                }) {
                    ForEach(
                     transactionsByDate[key] ?? [], id: \.self) {
                         TransactionCell(item: $0)
                             .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                     }
                }
            }
        }
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            BudgetTransactionHeader()
                .contentShape(Rectangle())
                .padding(.vertical)
            transactionsByDateList()
        }
    }
}

struct BudgetTransactions_Previews: PreviewProvider {

   static var previews: some View {
      BudgetTransactions(
        transactions: MockDataTransaction().transactions, isPresented: .constant(true))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}

