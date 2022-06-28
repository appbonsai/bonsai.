//
//  Budget.swift
//  bonsai
//
//  Created by antuan.khoanh on 19/06/2022.
//

import Foundation
import CoreData

@objc(Budget)
public class Budget: NSManagedObject, Identifiable {
    @NSManaged public var name: String
    @NSManaged public var totalAmount: NSDecimalNumber
    @NSManaged public var currentAmount: NSDecimalNumber
    @NSManaged public var periodDays: Int64
    
    @discardableResult convenience init(
        context: NSManagedObjectContext,
        name: String,
        totalAmount: NSDecimalNumber = 0,
        periodDays: Int64 = 0
    ) {
        self.init(context: context)
        self.name = name
        self.totalAmount = totalAmount
        self.currentAmount = totalAmount
        self.periodDays = periodDays
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        NSFetchRequest<Budget>(entityName: "Budget")
    }
}

