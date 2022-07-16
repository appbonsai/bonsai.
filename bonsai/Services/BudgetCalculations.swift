//
//  BudgetCalculations.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

protocol BudgetCalculationsProtocol {
    func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber
    func calculateBudgetCurrentAmount(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber?
    func calculateTotalMoneyLeft(total: NSDecimalNumber, currentAmount: NSDecimalNumber) -> NSDecimalNumber
    func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber
    func calculateBudgetTotalAmount(currentAmount: NSDecimalNumber, totalSpend: NSDecimalNumber) -> NSDecimalNumber
}

final class BudgetCalculations: BudgetCalculationsProtocol {
    
    func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
        currentAmount.dividing(by: NSDecimalNumber(value: periodDays)).round()
    }
    
    func calculateBudgetCurrentAmount(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber? {
        if spending > amount {
            return nil
        }
        return amount.subtracting(spending).round()
    }
    
    func calculateTotalMoneyLeft(total: NSDecimalNumber, currentAmount: NSDecimalNumber) -> NSDecimalNumber {
        total.subtracting(currentAmount).round()
    }
    
    func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber {
        let currentAmount = transactionAmounts
            .reduce(0, { $1.adding($0) })
        return currentAmount.round()
    }
    
    func calculateBudgetTotalAmount(currentAmount: NSDecimalNumber, totalSpend: NSDecimalNumber) -> NSDecimalNumber {
        currentAmount.adding(totalSpend).round()
    }
}

