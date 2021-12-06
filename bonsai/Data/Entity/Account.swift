//
//  Account+CoreDataClass.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//
//

import Foundation
import CoreData

@objc(Account)
public class Account: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID
    @NSManaged public var title: String

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        NSFetchRequest<Account>(entityName: "Account")
    }
}
