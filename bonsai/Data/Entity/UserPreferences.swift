//
//  UserPreferences.swift
//  bonsai
//
//  Created by Vladimir Korolev on 6/11/22.
//

import CoreData

@objc(UserPreferences)
public class UserPreferences: NSManagedObject {

   @NSManaged public var currencyCode: String?

   @discardableResult convenience init(
      context: NSManagedObjectContext,
      currencyCode: String
   ) {
      self.init(context: context)
      self.currencyCode = currencyCode
   }

   @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPreferences> {
      NSFetchRequest<UserPreferences>(entityName: "UserPreferences")
   }
}
