//
//  BudgetCalculations.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

protocol BudgetCalculationsProtocol {
    @discardableResult
    func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber
    @discardableResult
    func calculateBudgetCurrentAmount(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber?
    @discardableResult
    func calculateTotalMoneyLeft(total: NSDecimalNumber, currentAmount: NSDecimalNumber) -> NSDecimalNumber
    @discardableResult
    func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber
    func calculateBudgetTotalAmount(currentAmount: NSDecimalNumber, totalSpend: NSDecimalNumber) -> NSDecimalNumber
}

final class BudgetCalculations: BudgetCalculationsProtocol {
    
    func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
        let diffValue = Float(truncating: currentAmount) / Float(periodDays)
        return .roundedDecimal(diffValue: diffValue)
    }
    
    func calculateBudgetCurrentAmount(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber? {
        if spending.floatValue > Float(truncating: amount) {
           return nil
        }
        let diffValue = Float(truncating: amount) - spending.floatValue
        return .roundedDecimal(diffValue: diffValue)
    }
    
    func calculateTotalMoneyLeft(total: NSDecimalNumber, currentAmount: NSDecimalNumber) -> NSDecimalNumber {
        let diffValue = total.floatValue - currentAmount.floatValue
        return .roundedDecimal(diffValue: diffValue)
    }
    
    func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber {
        let currentAmount = transactionAmounts
            .map { $0.floatValue }
            .reduce(0, +)
        return .roundedDecimal(diffValue: currentAmount)
    }
    
    func calculateBudgetTotalAmount(currentAmount: NSDecimalNumber, totalSpend: NSDecimalNumber) -> NSDecimalNumber {
        let diffValue = currentAmount.floatValue + totalSpend.floatValue
        return .roundedDecimal(diffValue: diffValue)
    }
}

