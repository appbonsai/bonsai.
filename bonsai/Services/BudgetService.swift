//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

protocol BudgetServiceProtocol {
    func getTotalBudget(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
    func getTotalMoneySpent(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
    func getMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber?
    func getTotalMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
}

final class BudgetService {
    
    private let budgetRepository: BudgetRepositoryProtocol
    private let budgetCalculations: BudgetCalculationsProtocol
    
    init(budgetRepository: BudgetRepositoryProtocol,
         budgetCalculations: BudgetCalculationsProtocol) {
        self.budgetRepository = budgetRepository
        self.budgetCalculations = budgetCalculations
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
    
    func getMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
        budgetCalculations.calculateMoneyCanSpendDaily(currentAmount: currentAmount, periodDays: periodDays)
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

