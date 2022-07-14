//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

public final class BudgetService {
    
    private let budgetRepository: BudgetRepositoryProtocol
    private let budgetCalculations: BudgetCalculationsProtocol
     
    init(budgetRepository: BudgetRepositoryProtocol,
         budgetCalculations: BudgetCalculationsProtocol) {
        self.budgetRepository = budgetRepository
        self.budgetCalculations = budgetCalculations
    }
    
//    func calculateAmount(spending: NSDecimalNumber) throws {
//        let budget = try getBudget()
//        if spending.floatValue > budget.currentAmount.floatValue {
//            throw BudgetAmountDoesNotEnough()
//        }
//        let diffValue = (budget.currentAmount.floatValue - spending.floatValue)
//        let currentAmount = roundedDecimal(diffValue: diffValue)
//        budget.setValue(currentAmount, forKeyPath: #keyPath(Budget.currentAmount))
//        try context.save()
//    }
    
 
    
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
