//
//  Transaction+CoreDataClass.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID
    @NSManaged public var amount: NSDecimalNumber
    @NSManaged public var title: String?
    @NSManaged public var date: Date
    @NSManaged public var category: Category
    @NSManaged public var account: Account
    @NSManaged public var tags: Set<Tag>
    public var type: `Type` {
        get {
            switch typeValue {
            case 0:
                return .income
            case 1:
                return .expense
            case 2:
                return .transfer(toAccount: toAccount!)
            default:
                fatalError("Invalid transaction type value \(typeValue)")
            }
        }
        set {
            switch newValue {
            case .income:
                typeValue = 0
                toAccount = nil
            case .expense:
                typeValue = 1
                toAccount = nil
            case .transfer(let account):
                typeValue = 2
                toAccount = account
            }
        }
    }

    @discardableResult convenience init(
        context: NSManagedObjectContext,
        id: UUID = UUID(),
        amount: NSDecimalNumber,
        title: String? = nil,
        date: Date,
        category: Category,
        account: Account,
        type: `Type`,
        tags: Set<Tag>
    ) {
        self.init(context: context)
        self.id = id
        self.amount = amount
        self.title = title
        self.date = date
        self.category = category
        self.account = account
        self.type = type
        tags.forEach(addToTags(_:))
    }

    @nonobjc class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    // MARK: Generated accessors for tags
    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

    // Note: Do not use these accessors, but use `type` instead
    @NSManaged public var toAccount: Account?
    @NSManaged public var typeValue: Int16
}

public extension Transaction {
   enum `Type`: Equatable {
        case income
        case expense
        case transfer(toAccount: Account)
    }
}
