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
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var amount: NSDecimalNumber
    @NSManaged public var periodDays: Int64
    @NSManaged public var createdDate: Date
    
    @discardableResult convenience init(
        context: NSManagedObjectContext,
        id: UUID = UUID(),
        name: String,
        totalAmount: NSDecimalNumber,
        periodDays: Int64,
        createdDate: Date
    ) {
        self.init(context: context)
        self.name = name
        self.id = id
        self.amount = totalAmount
        self.periodDays = periodDays
        self.createdDate = createdDate
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        NSFetchRequest<Budget>(entityName: "Budget")
    }
}
