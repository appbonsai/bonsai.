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
   @NSManaged public var category: Category?
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
   public var currency: Currency.Validated {
      get {
         Currency.Validated.all.first(where: { $0.code == currencyCode }) ?? .current
      }
      set {
         currencyCode = newValue.code
      }
   }

   @discardableResult convenience init(
      context: NSManagedObjectContext,
      id: UUID = UUID(),
      amount: NSDecimalNumber,
      title: String? = nil,
      date: Date,
      category: Category? = nil,
      account: Account,
      type: `Type`,
      tags: Set<Tag>,
      currency: Currency.Validated = .current
   ) {
      self.init(context: context)
      self.id = id
      self.amount = amount
      self.title = title
      self.date = date
      self.category = category
      self.account = account
      self.type = type
      self.currency = currency
      tags.forEach(addToTags(_:))
   }

   func update(
      amount: NSDecimalNumber? = nil,
      title: String? = nil,
      date: Date? = nil,
      category: Category? = nil,
      account: Account? = nil,
      type: `Type`? = nil,
      tags: Set<Tag>? = nil,
      currency: Currency.Validated? = nil
   ) {
      if let amount = amount {
         self.amount = amount
      }
      if let title = title {
         self.title = title
      }
      if let date = date {
         self.date = date
      }
      if let category = category {
         self.category = category
      }
      if let account = account {
         self.account = account
      }
      if let type = type {
         self.type = type
      }
      if let currency = currency {
         self.currency = currency
      }
      if let tags = tags, self.tags != tags {
         self.tags.forEach(removeFromTags(_:))
         tags.forEach(addToTags(_:))
      }
   }

   @nonobjc class func fetchRequest() -> NSFetchRequest<Transaction> {
      NSFetchRequest<Transaction>(entityName: "Transaction")
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

   // Note: Do not use this accessor, but use `currency` instead
   @NSManaged public var currencyCode: String
}

public extension Transaction {
   enum `Type`: Equatable {
      case income
      case expense
      case transfer(toAccount: Account)
   }
}
