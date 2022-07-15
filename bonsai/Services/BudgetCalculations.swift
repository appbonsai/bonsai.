//
//  BudgetCalculations.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

public protocol BudgetCalculationsProtocol {
    @discardableResult
    func calculateMoneyCanSpendToday(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber
    @discardableResult
    func calculateAmount(currentAmount: NSDecimalNumber, spending: NSDecimalNumber) -> NSDecimalNumber?
}

class BudgetCalculations: BudgetCalculationsProtocol {
    
    @discardableResult
    func calculateMoneyCanSpendToday(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
        let diffValue = Float(truncating: currentAmount) / Float(periodDays)
        return .roundedDecimal(diffValue: diffValue)
    }
    @discardableResult
    func calculateAmount(currentAmount: NSDecimalNumber, spending: NSDecimalNumber) -> NSDecimalNumber? {
        if spending.floatValue > Float(truncating: currentAmount) {
           return nil
        }
        let diffValue = Float(truncating: currentAmount) - spending.floatValue
        return .roundedDecimal(diffValue: diffValue)
    }
    
    func calculateTotalMoneyLeft(total: NSDecimalNumber, currentAmount: NSDecimalNumber) -> NSDecimalNumber {
        let diffValue = total.floatValue - currentAmount.floatValue
        return .roundedDecimal(diffValue: diffValue)
    }
    
}

extension NSDecimalNumber {
    static func roundedDecimal(diffValue: Float, with scale: Int16 = 2) -> NSDecimalNumber {
        let behaviour = NSDecimalNumberHandler(
            roundingMode: .plain,
            scale: scale,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: true)
        return NSDecimalNumber(value: diffValue).rounding(accordingToBehavior: behaviour)
    }
}
