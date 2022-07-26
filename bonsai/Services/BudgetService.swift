//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

protocol BudgetCalculationServiceProtocol {
   func getTotalBudget() -> NSDecimalNumber?
   func getTotalMoneySpent(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
   func getMoneyCanSpendDaily(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
   func getTotalMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
}

protocol BudgetRepositoryServiceProtocol {
   func createBudget(name: String, with budgetAmount: NSDecimalNumber, on periodDays: Int64, createdDate: Date) -> Budget
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
   
   func createBudget(name: String, with budgetAmount: NSDecimalNumber, on periodDays: Int64, createdDate: Date = Date()) -> Budget {
       budgetRepository.create(name: name, totalAmount: budgetAmount, periodDays: periodDays, createdDate: createdDate)
   }
   
   func deleteBudget() {
      budgetRepository.delete()
   }
   
   func getTotalMoneySpent(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
      budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
   }
   
   func getTotalBudget() -> NSDecimalNumber? {
      guard let budget = budgetRepository.getBudget() else {
         return nil
      }
      return budget.amount
   }
   
    func getMoneyCanSpendDaily(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
        guard let budget = budgetRepository.getBudget(),
              let moneyLeft = getTotalMoneyLeft(with: transactionAmounts) else {
            return nil
        }
        let dayLeft = budgetCalculations.calculateDayLeft(fromDate: budget.createdDate, toDate: .now)
        let dailyBudget = budgetCalculations.calculateMoneyCanSpendDaily(currentAmount: moneyLeft, periodDays: budget.periodDays - Int64(dayLeft))
        return dailyBudget
    }
   
   func getTotalMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
      guard let budget = budgetRepository.getBudget() else {
         return nil
      }
      let totalSpend = budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
      let newAmount = budgetCalculations.calculateTotalMoneyLeft(with: budget.amount, after: totalSpend)
      if let newAmount = newAmount {
         return newAmount
      }
      return nil
   }
}

