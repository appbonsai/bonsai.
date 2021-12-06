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
    @NSManaged public var color: UIColor
    @NSManaged public var icon: UIImage

    @discardableResult convenience init(
        context: NSManagedObjectContext,
        id: UUID = UUID(),
        title: String,
        color: UIColor,
        icon: UIImage
    ) {
        self.init(context: context)
        self.id = id
        self.title = title
        self.color = color
        self.icon = icon
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        NSFetchRequest<Category>(entityName: "Category")
    }
}
