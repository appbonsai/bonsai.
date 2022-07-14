//
//  BudgetCalculations.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

public protocol BudgetCalculationsProtocol {
    
}

private class BudgetCalculations: BudgetCalculationsProtocol {
    
    func calculateMoneyCanSpendToday(currentAmount: Float, periodDays: Int64) -> NSDecimalNumber {
        let diffValue = currentAmount / Float(periodDays)
        return NSDecimalNumber.roundedDecimal(diffValue: diffValue)
    }
    
    func calculateAmount(currentAmount: Float, spending: NSDecimalNumber) -> NSDecimalNumber? {
        if spending.floatValue > currentAmount {
           return nil
        }
        let diffValue = currentAmount - spending.floatValue
        return NSDecimalNumber.roundedDecimal(diffValue: diffValue)
    }
}
