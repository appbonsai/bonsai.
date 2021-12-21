//
//  DataController.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//

import Foundation
import CoreData

final class DataController: ObservableObject {

   static let sharedInstance = DataController()
   let container = NSPersistentContainer(name: "Core")
   let mainContext: NSManagedObjectContext
   let backgroundContext: NSManagedObjectContext

   private init() {
      UIColorValueTransformer.register()
      UIImageValueTransformer.register()
      let description = container.persistentStoreDescriptions.first
      description?.type = NSSQLiteStoreType
      container.loadPersistentStores { description, error in
         if let error = error {
            fatalError("Core Data failed to load: \(error.localizedDescription)")
         }
      }
      mainContext = container.viewContext
      backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
      backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      backgroundContext.parent = mainContext
      container.viewContext.automaticallyMergesChangesFromParent = true
   }
}
