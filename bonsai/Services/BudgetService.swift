//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation
import CoreData

class BudgetService {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        self.context = context
    }
    
    @discardableResult
    func create(name: String, totalAmount: NSDecimalNumber, periodDays: Int64) throws -> Budget {
        let budget = Budget(
            context: context,
            name: name,
            totalAmount: totalAmount,
            periodDays: periodDays)
        try context.save()
        return budget
    }
    
    func getBudget() throws -> Budget {
        let request: NSFetchRequest<Budget> = Budget.fetchRequest()
        request.fetchLimit = 1
        guard let budget = try context.fetch(request).first else {
            throw BudgetDoesntExist()
        }
        return budget
    }
    
    @discardableResult
    func update(budget: Budget) throws -> Budget {
        let currentBudget = try getBudget()
        currentBudget.setValue(budget.name, forKeyPath: #keyPath(Budget.name))
        currentBudget.setValue(budget.totalAmount, forKeyPath: #keyPath(Budget.totalAmount))
        currentBudget.setValue(budget.periodDays, forKeyPath: #keyPath(Budget.periodDays))
        try context.save()
        return currentBudget
    }
    
    func delete() throws {
        let currentBudget = try getBudget()
        context.delete(currentBudget)
        try context.save()
    }
    
    func calculateMoneyCanSpendToday(currentAmount: Float, periodDays: Int64) -> NSDecimalNumber {
        let diffValue = currentAmount / Float(periodDays)
        return NSDecimalNumber.roundedDecimal(diffValue: diffValue)
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
    
    func calculateAmount(currentAmount: Float, spending: NSDecimalNumber) -> NSDecimalNumber? {
        if spending.floatValue > currentAmount {
           return nil
        }
        let diffValue = currentAmount - spending.floatValue
        return NSDecimalNumber.roundedDecimal(diffValue: diffValue)
    }
    
    struct BudgetDoesntExist: Error { }
    
    struct BudgetAmountDoesNotEnough: Error { }
    
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
