//
//  TransactionCell.swift
//  bonsai
//
//  Created by hoang on 08.12.2021.
//

import SwiftUI

extension String {
   func takeIfNotEmpty() -> String? {
      if isEmpty { return nil }
      return self
   }
}

struct TransactionCell: View {

   struct Model {
      let color: LinearGradient
      let icon: Image
      let title: String
      let type: Transaction.`Type`
      let amount: String

      init(transaction: Transaction) {
         self.color = transaction.category.color.asGradient
         self.icon = transaction.category.icon.img
         self.title = transaction.title?.takeIfNotEmpty() ?? transaction.category.title
         self.type = transaction.type
         self.amount = transaction.amount.stringValue
      }
   }

   let model: Model

   var body: some View {
      HStack {
         model.color
            .mask(model.icon)
            .frame(width: 22, height: 22)
            .padding()
         Text(model.title)
            .font(BonsaiFont.body_17)
            .foregroundColor(Color.white)
         Spacer()
          
         Text(model.type == .expense ?
              "-\(model.amount)" : "+\(model.amount)")
            .font(BonsaiFont.body_17)
            .foregroundColor(model.type == .expense ? BonsaiColor.secondary : BonsaiColor.green)
            .padding()
      }
   }
}

struct TransactionCell_Previews: PreviewProvider {
   private static let viewContext = DataController.sharedInstance.container.viewContext

   private static let transaction = Transaction(context: Self.viewContext,
                                                amount: 20.0,
                                                date: .from(year: 2021, month: 8, day: 28),
                                                category: .init(
                                                   context: viewContext,
                                                   title: "Restaurant",
                                                   color: .green,
                                                   icon: .star),
                                                account: .init(
                                                   context: viewContext,
                                                   title: "BonsaiTest"),
                                                type: .expense,
                                                tags: .init())
   static var previews: some View {
      TransactionCell(model: .init(transaction: transaction))
         .background(Color.blue)
   }
}
