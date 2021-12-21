//
//  Budget.swift
//  bonsai
//
//  Created by hoang on 04.01.2022.
//

import Foundation
import CoreData

@objc(Budget)
public class Budget: NSManagedObject, Identifiable, BudgetProtocol {
   @NSManaged public var id: UUID
   @NSManaged public var name: String
   @NSManaged public var amount: Decimal // NSDecimal
   @NSManaged public var periodDays: Int64
   public var budgetID: String { id.uuidString }

   @discardableResult convenience init(
      context: NSManagedObjectContext,
      id: UUID = UUID(),
      name: String,
      amount: Decimal,
      periodDays: Int64
   ) {
      self.init(context: context)
      self.id = id
      self.name = name
      self.amount = amount
      self.periodDays = periodDays
   }

   @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
      NSFetchRequest<Budget>(entityName: "Budget")
   }
}
