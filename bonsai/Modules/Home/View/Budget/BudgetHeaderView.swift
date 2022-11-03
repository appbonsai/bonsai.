//
//  BudgetHeaderView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 08.12.2021.
//

import SwiftUI

struct BudgetHeaderView: View {

   @EnvironmentObject var budgetService: BudgetService

   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
   var transactions: FetchedResults<Transaction>

   func getPercentage() -> Double {
      getTotalMoneySpent() * 100.0 / getTotalBudgetAmount() / 100.0
   }

   func getTotalMoneySpent() -> Double {
      guard let creationDate = budgetService.getBudget()?.createdDate else { return 0.0 }
      let allAmount = transactions
         .filter { $0.date > creationDate }
         .map { $0.amount }
      return budgetService.getTotalMoneySpent(with: allAmount).doubleValue
   }

   func getTotalBudgetAmount() -> Double {
      budgetService.getTotalBudget().doubleValue
   }

   @Binding var progress: Double

   var body: some View {
      ZStack {
         BonsaiColor.newPurple
            .opacity(0.8)

         HStack(spacing: 16) {

            CircularProgressView(progress: getPercentage())
               .foregroundColor(BonsaiColor.text)
               .frame(width: 75, height: 75)
               .padding(.leading, 20)

            VStack(alignment: .leading) {
               Text(L.Money_spent)
                  .font(BonsaiFont.body_17)
                  .fontWeight(.regular)
                  .foregroundColor(BonsaiColor.text)

               Text("\(Currency.Validated.current.symbol) \(getTotalMoneySpent(), specifier: "%.2f")")
                  .font(BonsaiFont.title_28)
                  .foregroundColor(.white)
               Text("out of \(Currency.Validated.current.symbol)\(getTotalBudgetAmount(), specifier: "%.0f")")
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
         .environmentObject(BudgetService(
            budgetRepository: BudgetRepository(),
            budgetCalculations: BudgetCalculations()
         ))
   }
}
