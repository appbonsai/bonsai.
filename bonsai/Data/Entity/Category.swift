//
//  Category+CoreDataClass.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//
//

import UIKit
import CoreData

@objc(Category)
public class Category: NSManagedObject, Identifiable {

   @NSManaged public var id: UUID
   @NSManaged public var title: String
   var icon: Icon {
      get {
         .init(rawValue: iconString) ?? .gameController
      }
      set {
         iconString = newValue.rawValue
      }
   }
   var color: Color {
      get {
         .init(rawValue: colorString) ?? .green
      }
      set {
         colorString = newValue.rawValue
      }
   }

   @discardableResult convenience init(
      context: NSManagedObjectContext,
      id: UUID = UUID(),
      title: String,
      color: Color,
      icon: Icon
   ) {
      self.init(context: context)
      self.id = id
      self.title = title
      self.colorString = color.rawValue
      self.iconString = icon.rawValue
   }

   @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
      NSFetchRequest<Category>(entityName: "Category")
   }

   // Note: Do not use this accessor, but use `color` instead
   @NSManaged public var colorString: String
   // Note: Do not use this accessor, but use `icon` instead
   @NSManaged public var iconString: String
}

// Category for use when no category was specified on transaction
extension Category {
   @UserDefault("Category.notSpecified.id")
   private(set) static var nonSpecifiedId: String?

   private(set) static var notSpecified = Category(
      context: DataController.sharedInstance.container.viewContext,
      id: { () -> UUID in
          let id = nonSpecifiedId ?? UUID().uuidString
          nonSpecifiedId = id
          return UUID(uuidString: id)!
      }(),
      title: "No category",
      color: .blue,
      icon: .star
   )
}
