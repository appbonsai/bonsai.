//
//  BudgetGateway.swift
//  bonsai
//
//  Created by hoang on 21.12.2021.
//

import Foundation
import CoreData

public protocol BudgetProtocol {
   var budgetID: String { get }
   var name: String { get }
   var amount: Decimal { get }
   var periodDays: Int64 { get }
}

public final class BudgetGateway {

   let mainContext: NSManagedObjectContext

   init(mainContext: NSManagedObjectContext = DataController.sharedInstance.mainContext) {
      self.mainContext = mainContext
   }

   @discardableResult
   func create(name: String, amount: Decimal, period: Int64) throws -> Budget {
      let budget = Budget(
         context: mainContext,
         name: name,
         amount: amount,
         periodDays: period)
      try mainContext.save()
      return budget
   }

   func update(budget: Budget) throws {
      try mainContext.save()
   }

   func delete(budget: Budget) throws {
      mainContext.delete(budget)
      try mainContext.save()
   }

   func getBudget(name: String) throws -> BudgetProtocol {
      let request: NSFetchRequest<Budget> = Budget.fetchRequest()
      request.fetchLimit = 1
      request.predicate = NSPredicate(format: "name == %@", name)
      guard let budget = try mainContext.fetch(request).first else {
         throw BudgetDoesntExist()
      }
      return budget
   }

   func getAllBudgets() throws -> [BudgetProtocol] {
      let request: NSFetchRequest<Budget> = Budget.fetchRequest()
      let budgets = try mainContext.fetch(request)
      return budgets
   }

   func spentCapacity(budgetName: String) throws -> Decimal {
      let budget = try getBudget(name: budgetName)
      return (budget.amount) / Decimal(Double(budget.periodDays).roundTo(places: 1))
   }

   func spentCapacityLessThanAvailable(budget: Budget) throws -> Decimal {
      let capacity = try spentCapacity(budgetName: budget.name)
      let result = ((budget.amount) + capacity) / Decimal(budget.periodDays)
      return result
   }

   func spentCapacityMoreThanAvailable(budget: Budget) throws -> Decimal {
      let capacity = try spentCapacity(budgetName: budget.name)
      let result = ((budget.amount) - capacity) / Decimal(budget.periodDays)
      return result
   }

   struct BudgetDoesntExist: Error {
   }

}

