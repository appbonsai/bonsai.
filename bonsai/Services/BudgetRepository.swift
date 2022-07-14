//
//  BudgetRepository.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation
import CoreData

public protocol BudgetRepositoryProtocol {
    func create(name: String, totalAmount: NSDecimalNumber, periodDays: Int64) throws -> Budget
    func getBudget() throws -> Budget
    func update(budget: Budget) throws -> Budget
    func delete() throws
}

private final class BudgetRepository: BudgetRepositoryProtocol {
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
    
    struct BudgetDoesntExist: Error { }
    
    struct BudgetAmountDoesNotEnough: Error { }
}
