//
//  BudgetCalculations.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

protocol BudgetCalculationsProtocol {
    func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber
    func calculateTotalMoneyLeft(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber?
    func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber
}

final class BudgetCalculations: BudgetCalculationsProtocol {
    
    func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
        currentAmount.dividing(by: NSDecimalNumber(value: periodDays)).round()
    }
    
    func calculateTotalMoneyLeft(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber? {
        if spending > amount {
            return nil
        }
        return amount.subtracting(spending).round()
    }
    
    func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber {
        let currentAmount = transactionAmounts
            .reduce(0, { $1.adding($0) })
        return currentAmount.round()
    }
}

