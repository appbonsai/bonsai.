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
    func getBudgetCurrentAmount(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
    func getMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber?
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
    
    func getMoneyLeft(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
        guard let budget = budgetRepository.getBudget() else {
            return nil
        }
        let totalSpend = budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
        let totalBudget = budgetCalculations.calculateBudgetTotalAmount(currentAmount: budget.amount, totalSpend: totalSpend)
        let totalMoneyLeft = budgetCalculations.calculateTotalMoneyLeft(total: totalBudget, currentAmount: budget.amount)
        return totalMoneyLeft
    }
    
    func getMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
        budgetCalculations.calculateMoneyCanSpendDaily(currentAmount: currentAmount, periodDays: periodDays)
    }
    
    func getBudgetCurrentAmount(with transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber? {
        guard let budget = budgetRepository.getBudget() else {
            return nil
        }
        let totalSpend = budgetCalculations.calculateTotalSpend(transactionAmounts: transactionAmounts)
        let newAmount = budgetCalculations.calculateBudgetCurrentAmount(with: budget.amount, after: totalSpend)
        if let newAmount = newAmount {
            budget.amount = newAmount
            budgetRepository.update(budget: budget)
            return newAmount
        }
        return nil
    }
}

