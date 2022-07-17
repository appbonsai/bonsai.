//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

protocol BudgetCalculationServiceProtocol {
   func getTotalBudget(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
   func getTotalMoneySpent(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
   func getMoneyCanSpendDaily() -> NSDecimalNumber?
   func getTotalMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
}

protocol BudgetRepositoryServiceProtocol {
   func createBudget(name: String, with budgetAmount: NSDecimalNumber, on periodDays: Int64) -> Budget
   func deleteBudget()
}

typealias BudgetServiceProtocol = BudgetCalculationServiceProtocol & BudgetRepositoryServiceProtocol

final class BudgetService: BudgetServiceProtocol {
   
   private let budgetRepository: BudgetRepositoryProtocol
   private let budgetCalculations: BudgetCalculationsProtocol
   
   init(budgetRepository: BudgetRepositoryProtocol,
        budgetCalculations: BudgetCalculationsProtocol) {
      self.budgetRepository = budgetRepository
      self.budgetCalculations = budgetCalculations
   }
   
   func createBudget(name: String, with budgetAmount: NSDecimalNumber, on periodDays: Int64) -> Budget {
      budgetRepository.create(name: name, totalAmount: budgetAmount, periodDays: periodDays)
   }
   
   func deleteBudget() {
      budgetRepository.delete()
   }
   
   func getTotalMoneySpent(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
      budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
   }
   
   func getTotalBudget(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
      guard let budget = budgetRepository.getBudget() else {
         return nil
      }
      let totalSpend = budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
      let totalBudget = budgetCalculations.calculateBudgetTotalAmount(currentAmount: budget.amount, totalSpend: totalSpend)
      return totalBudget
   }
   
   func getMoneyCanSpendDaily() -> NSDecimalNumber? {
      guard let budget = budgetRepository.getBudget() else {
         return nil
      }
      let dailyBudget = budgetCalculations.calculateMoneyCanSpendDaily(currentAmount: budget.amount, periodDays: budget.periodDays)
      return dailyBudget
   }
   
   func getTotalMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
      guard let budget = budgetRepository.getBudget() else {
         return nil
      }
      let totalSpend = budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
      let newAmount = budgetCalculations.calculateTotalMoneyLeft(with: budget.amount, after: totalSpend)
      if let newAmount = newAmount {
         budget.amount = newAmount
         budgetRepository.update(budget: budget)
         return newAmount
      }
      return nil
   }
}

