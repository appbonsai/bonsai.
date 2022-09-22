//
//  TransactionCell.swift
//  bonsai
//
//  Created by hoang on 08.12.2021.
//

import SwiftUI

struct TransactionCell: View {

   let item: Transaction

   init(item: Transaction) {
      self.item = item
   }

   var body: some View {
      HStack {
         item.category.color.asGradient
            .mask(item.category.icon.img)
            .frame(width: 22, height: 22)
            .padding()
         Text(item.category.title)
            .font(BonsaiFont.body_17)
            .foregroundColor(Color.white)
         Spacer()
          
         Text(item.type == .expense ?
              "-\(item.amount)" : "\(item.amount)")
            .font(BonsaiFont.body_17)
            .foregroundColor(Color.white)
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
      TransactionCell(item: transaction)
         .background(Color.blue)
   }
}
