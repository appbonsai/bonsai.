//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation
import SwiftUI

protocol BudgetRepositoryServiceProtocol {
    func createBudget(name: String, with budgetAmount: NSDecimalNumber, on periodDays: Int64, createdDate: Date) -> Budget
}

final class BudgetService: ObservableObject, BudgetRepositoryServiceProtocol {
    private let budgetRepository: BudgetRepositoryProtocol
    private let budgetCalculations: BudgetCalculationsProtocol
    
    init(budgetRepository: BudgetRepositoryProtocol,
         budgetCalculations: BudgetCalculationsProtocol) {
        self.budgetRepository = budgetRepository
        self.budgetCalculations = budgetCalculations
    }
    
    func createBudget(name: String, with budgetAmount: NSDecimalNumber, on periodDays: Int64, createdDate: Date = Date()) -> Budget {
        budgetRepository.create(name: name, totalAmount: budgetAmount, periodDays: periodDays, createdDate: createdDate)
    }

   func getTotalMoneySpent(
      with transactionAmounts: [NSDecimalNumber]
   ) -> NSDecimalNumber {
      budgetCalculations.calculateTotalSpend(
         transactionAmounts: transactionAmounts
      )
   }
    
    func getTotalBudget() -> NSDecimalNumber {
        guard let budget = budgetRepository.getBudget() else {
            return .zero
        }
       return budget.amount
    }

   func getMoneyCanSpendDaily(
      with transactionAmounts: [NSDecimalNumber],
      budget: Budget
   ) -> NSDecimalNumber {
      budgetCalculations.calculateMoneyCanSpendDaily(
         currentAmount: getTotalMoneyLeft(
            with: transactionAmounts,
            budget: budget
         ),
         periodDays: budget.periodDays - Int64(budgetCalculations.calculateDayLeft(
            fromDate: budget.createdDate,
            toDate: .now
         ))
      )
   }

   func getTotalMoneyLeft(
      with transactionAmounts: [NSDecimalNumber],
      budget: Budget
   ) -> NSDecimalNumber {
      budgetCalculations.calculateTotalMoneyLeft(
         with: budget.amount,
         after: budgetCalculations.calculateTotalSpend(
            transactionAmounts: transactionAmounts
         )
      ) ?? .zero
   }

   func getMostExpensiveCategories(
      transactions: some Sequence<Transaction>
   ) -> [Category] {
      let sortedCategories = transactions
         .sorted { $0.amount > $1.amount }
         .compactMap { $0.category }
      if sortedCategories.count > 3 {
         return Array(sortedCategories[0...2])
      } else {
         return sortedCategories
      }
   }

   func filterTransactions(
      all transactions: some Sequence<Transaction>,
      budget: Budget
   ) -> [Transaction] {
      transactions.filter { $0.date > budget.createdDate}
   }
}
