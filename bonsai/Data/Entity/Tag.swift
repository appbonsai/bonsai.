//
//  Tag+CoreDataClass.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID
    @NSManaged public var title: String

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        NSFetchRequest<Tag>(entityName: "Tag")
    }
}
