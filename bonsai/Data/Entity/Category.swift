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

   enum Image {
      case icon(Icon)
      case emoji(String)
   }
   var image: Image {
      get {
         if let icon = Icon(rawValue: iconString) {
            return .icon(icon)
         }
         if let emoji = Emoji.fromStorage(text: iconString) {
            return .emoji(emoji)
         }
         return .icon(.gameController)
      }
      set {
         if case .emoji(let string) = newValue {
            iconString = Emoji.toStorage(emoji: string) ?? ""
         }
         if case .icon(let icon) = newValue {
            iconString = icon.rawValue
         }
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
      image: Image
   ) {
      self.init(context: context)
      self.id = id
      self.title = title
      self.colorString = color.rawValue
      self.iconString = {
         switch image {
         case .icon(let icon):
            return icon.rawValue
         case .emoji(let string):
            return Emoji.toStorage(emoji: string) ?? ""
         }
      }()
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
      image: .icon(.star)
   )
}
