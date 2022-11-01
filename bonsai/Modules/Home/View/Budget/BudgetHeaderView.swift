//
//  BudgetHeaderView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 08.12.2021.
//

import SwiftUI

struct BudgetHeaderView: View {
    @EnvironmentObject var budgetService: BudgetService
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>
    
    func getPercentage() -> Double {
        let budgetAmount = budgetService.getTotalBudget()
        let allAmount = transactions.map { $0.amount }
        let totalBudgetSpent = budgetService.getTotalMoneySpent(with: allAmount)
        return totalBudgetSpent.doubleValue * 100.0 / budgetAmount.doubleValue / 100.0
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
                    Text("Money Spent")
                        .font(BonsaiFont.body_17)
                        .fontWeight(.regular)
                        .foregroundColor(BonsaiColor.text)
                    
                    Text("$14.00")
                        .font(BonsaiFont.title_28)
                        .foregroundColor(.white)
                    Text("out of $28")
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
