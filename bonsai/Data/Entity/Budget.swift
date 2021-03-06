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
    @NSManaged public var amount: NSDecimalNumber
    @NSManaged public var periodDays: Int64
    
    @discardableResult convenience init(
        context: NSManagedObjectContext,
        name: String,
        totalAmount: NSDecimalNumber,
        periodDays: Int64
    ) {
        self.init(context: context)
        self.name = name
        self.amount = totalAmount
        self.periodDays = periodDays
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        NSFetchRequest<Budget>(entityName: "Budget")
    }
}

