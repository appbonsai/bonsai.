//
//  BudgetHeaderView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 08.12.2021.
//

import SwiftUI

struct BudgetHeaderView: View {

   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
   var transactions: FetchedResults<Transaction>

   @FetchRequest(sortDescriptors: [])
   private var budgets: FetchedResults<Budget>
   private var budget: Budget? { budgets.first }

   func getPercentage() -> NSDecimalNumber {
      let total = getTotalBudgetAmount()
      guard total > 0 else { return .zero }
      return getTotalMoneySpent()
         .multiplying(by: 100)
         .dividing(by: total)
         .dividing(by: 100)
         .round()
   }

   func getTotalMoneySpent() -> NSDecimalNumber {
      guard let budget else { return .zero }
      return BudgetCalculator.spent(
         budget: budget,
         transactions: transactions
      )
   }

   func getTotalBudgetAmount() -> NSDecimalNumber {
      (budget?.amount ?? .zero).round(0)
   }

   @Binding var progress: Double

   var body: some View {
      ZStack {
         BonsaiColor.newPurple
            .opacity(0.8)

         HStack(spacing: 16) {

            CircularProgressView(progress: getPercentage().doubleValue)
               .foregroundColor(BonsaiColor.text)
               .frame(width: 75, height: 75)
               .padding(.leading, 20)

            VStack(alignment: .leading) {
               Text(L.moneySpent)
                  .font(BonsaiFont.body_17)
                  .fontWeight(.regular)
                  .foregroundColor(BonsaiColor.text)

               Text("\(Currency.Validated.current.symbol) \(getTotalMoneySpent())")
                  .font(BonsaiFont.title_28)
                  .foregroundColor(.white)
               Text("\(L.outOf) \(Currency.Validated.current.symbol)\(getTotalBudgetAmount())")
                  .font(BonsaiFont.body_15)
                  .fontWeight(.regular)
                  .foregroundColor(BonsaiColor.text)

            }

            Spacer()
         }
         .padding(.vertical, 28)
      }
   }
}

struct BudgetHeaderView_Previews: PreviewProvider {
   static var previews: some View {
      BudgetHeaderView(progress: .constant(0.5))
   }
}
