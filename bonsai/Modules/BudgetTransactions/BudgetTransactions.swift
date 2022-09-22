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
   
   private let dragGestureOnChanged: (DragGesture.Value) -> Void
   private let dragGestureOnEnded: () -> (Void)

   init(transactions: [Transaction],
        dragGestureOnChanged: @escaping (DragGesture.Value) -> Void,
        dragGestureOnEnded: @escaping () -> (Void)) {
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
      self.dragGestureOnChanged = dragGestureOnChanged
      self.dragGestureOnEnded = dragGestureOnEnded
   }

   var body: some View {
      ZStack {
         VisualEffectView(
            effect: UIBlurEffect(style: .dark))
            .edgesIgnoringSafeArea(.all)
         VStack(alignment: .leading) {
            BudgetTransactionHeader()
               .contentShape(Rectangle())
               .gesture(
                  DragGesture()
                     .onChanged { value in
                        dragGestureOnChanged(value)
                     }
                     .onEnded { _ in
                        dragGestureOnEnded()
                     }
               )
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
            .onDisappear {
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
         transactions: MockDataTransaction().transactions, dragGestureOnChanged: { _ in }, dragGestureOnEnded: { })
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}

