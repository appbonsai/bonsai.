//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation
import SwiftUI

protocol BudgetCalculationServiceProtocol {
    func getTotalBudget() -> NSDecimalNumber
    func getTotalMoneySpent(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber
    func getMoneyCanSpendDaily(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber
    func getTotalMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber
}

protocol BudgetRepositoryServiceProtocol {
    func getBudget() -> Budget?
    func createBudget(name: String, with budgetAmount: NSDecimalNumber, on periodDays: Int64, createdDate: Date) -> Budget
    func deleteBudget()
}

typealias BudgetServiceProtocol = BudgetCalculationServiceProtocol & BudgetRepositoryServiceProtocol

final class BudgetService: ObservableObject, BudgetServiceProtocol {
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
    
    func getBudget() -> Budget? {
        budgetRepository.getBudget()
    }
    
    func deleteBudget() {
        budgetRepository.delete()
    }
    
    func updateBudget(budget: Budget) {
        budgetRepository.update(budget: budget)
    }
    
    func getTotalMoneySpent(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber {
        budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
    }
    
    func getTotalBudget() -> NSDecimalNumber {
        guard let budget = budgetRepository.getBudget() else {
            return .zero
        }
        return budget.amount
    }
    
    func getMoneyCanSpendDaily(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber {
        guard let budget = budgetRepository.getBudget() else {
            return .zero
        }
        let moneyLeft = getTotalMoneyLeft(with: transactionAmounts)
        let dayLeft = budgetCalculations.calculateDayLeft(fromDate: budget.createdDate, toDate: .now)
        let dailyBudget = budgetCalculations.calculateMoneyCanSpendDaily(currentAmount: moneyLeft, periodDays: budget.periodDays - Int64(dayLeft))
        return dailyBudget
    }
    
    func getTotalMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber {
        guard let budget = budgetRepository.getBudget() else {
            return .zero
        }
        let totalSpend = budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
        let newAmount = budgetCalculations.calculateTotalMoneyLeft(with: budget.amount, after: totalSpend)
        if let newAmount = newAmount {
            return newAmount
        }
        return .zero
    }

   static func getMostExpensiveCategories(
      transactions: [Transaction]
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
}
