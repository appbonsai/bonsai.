//
//  BudgetDetails.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetDetails: View {

   @Environment(\.managedObjectContext) private var moc

   @State var size: CGFloat = UIScreen.main.bounds.height

   var body: some View {
      ZStack {
         VStack {
            VStack(alignment: .leading) {
               BudgetNameView()
                  .frame(height: 33)
                  .padding(.leading, 8)

               Text("Handsome, you’re doing well!")
                  .font(BonsaiFont.body_15)
                  .foregroundColor(BonsaiColor.text)
                  .padding(.horizontal)
            }

            HStack(alignment: .center, spacing: 16) {
               BudgetMoneyTitleView()
                  .padding(.leading, 16)
               BudgetMoneyTitleView()
            }
            .frame(height: 63)

            ZStack {
               Image(Asset.tree.name)
                  .resizable()

               VStack {
                  HStack(alignment: .center, spacing: 16) {
                     BudgetFlowView()
                        .shadow(color: .black, radius: 7, x: 0, y: 4)

                     BudgetFlowView()
                        .shadow(color: .black, radius: 7, x: 0, y: 4)
                  }
                  .frame(height: 116)
                  .padding(.horizontal, 16)
                  .padding(.top, -14)

                  Spacer()

                  BudgetDragUpView()
                     .padding(.bottom, 74)
                     .gesture(DragGesture()
                                 .onChanged({ value in
                        if value.translation.height < 0 {
                           // up
                           size = 400
                        }
                     }))
               }
            }
            .padding(.top, 16)
         }
         .padding(.top, 38)
         .background(BonsaiColor.back)
         .ignoresSafeArea()

         BudgetTransactions(transactions: [Transaction(
            context: self.moc,
            amount: 1000,
            date: Date(),
            category: .init(context: self.moc,
                            id: UUID(),
                            title: "category",
                            color: Category.Color.red,
                            icon: Category.Icon.airplane),
            account: .init(context: self.moc,
                           id: UUID(),
                           title: "account"),
            type: .expense,
            tags: .init())])
            .offset(y: size)
      }
   }
}

struct BudgetDetails_Previews: PreviewProvider {
   static var previews: some View {
      BudgetDetails()
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")

   }
}
