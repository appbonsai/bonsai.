//
//  BudgetRepository.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation
import CoreData

protocol BudgetRepositoryProtocol {
    @discardableResult
    func create(name: String, totalAmount: NSDecimalNumber, periodDays: Int64) throws -> Budget
    @discardableResult
    func getBudget() -> Budget?
    @discardableResult
    func update(budget: Budget) -> Budget?
    func delete() throws
}

final class BudgetRepository: BudgetRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        self.context = context
    }
    
    func create(name: String, totalAmount: NSDecimalNumber, periodDays: Int64) throws -> Budget {
        let budget = Budget(
            context: context,
            name: name,
            totalAmount: totalAmount,
            periodDays: periodDays)
        try context.save()
        return budget
    }
    
    func getBudget() -> Budget? {
        let request: NSFetchRequest<Budget> = Budget.fetchRequest()
        request.fetchLimit = 1
        do {
            guard let budget = try context.fetch(request).first else {
                throw BudgetDoesntExist()
            }
            return budget
        } catch {
            return nil
        }
    }
    
    func update(budget: Budget) -> Budget? {
        guard let currentBudget = getBudget() else {
            return nil
        }
        currentBudget.setValue(budget.name, forKeyPath: #keyPath(Budget.name))
        currentBudget.setValue(budget.amount, forKeyPath: #keyPath(Budget.amount))
        currentBudget.setValue(budget.periodDays, forKeyPath: #keyPath(Budget.periodDays))
        do {
            try context.save()
            return currentBudget
        } catch {
            return nil
        }
    }
    
    func delete() {
        if let currentBudget = getBudget() {
            context.delete(currentBudget)
        }
        do { try context.save() }
        catch {
            print(BudgetDoesntExist())
        }
    }
    
    private struct BudgetDoesntExist: Error { }
    
}
