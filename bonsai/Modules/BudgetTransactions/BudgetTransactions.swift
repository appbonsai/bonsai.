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

   init(transactions: [Transaction]) {
      var dict = OrderedDictionary<String, [Transaction]>()
      let sortedTransaction = transactions
         .sorted(by: { $0.date > $1.date  })
      for transaction in sortedTransaction {
         if transaction.type == .expense {
            let date = transaction.date.dateString()
            if var arr = dict[date] {
               arr.append(transaction)
               dict[date] = arr
            } else {
               dict[date] = [transaction]
            }
         }
      }
      transactionsByDate = dict
   }

   var body: some View {
      ZStack {
         VisualEffectView(
            effect: UIBlurEffect(style: .dark))
            .edgesIgnoringSafeArea(.all)

         VStack(alignment: .leading) {
            HStack {
               Spacer()
               RoundedCorner()
                  .foregroundColor(BonsaiColor.disabled)
                  .frame(width: 60, height: 5, alignment: .center)
                  .cornerRadius(25, corners: .allCorners)
               Spacer()
            }
            .padding(.top, 20)

            Text("Transactions")
               .font(BonsaiFont.title_headline_17)
               .foregroundColor(Color.white)
               .padding(.leading, 16)
               .frame(height: 17)
               .padding(.top, 7)
            List {
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
                              .listRowBackground(Color.clear)
                              .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                  }
               }
            }
            .listRowBackground(Color.clear)
            .onAppear {
               UITableView.appearance().separatorStyle = .singleLine
               UITableView.appearance().backgroundColor = .clear
            }
         }
      }
   }
}

struct BudgetTransactions_Previews: PreviewProvider {

   static var previews: some View {
      BudgetTransactions(
         transactions: MockDataTransaction.transactions)
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}

