//
//  DataControllerTests.swift
//  BudgetTests
//
//  Created by hoang on 06.01.2022.
//

import XCTest
import CoreData

struct DataControllerTests {

   let persistentContainer: NSPersistentContainer
   let mainContext: NSManagedObjectContext
   let backgroundContext: NSManagedObjectContext

   init() {
      persistentContainer = NSPersistentContainer(name: "Core")
      let descriptioт = persistentContainer.persistentStoreDescriptions.first
      descriptioт?.type = NSInMemoryStoreType
      persistentContainer.loadPersistentStores { description, error in
         guard error == nil else {
            fatalError()
         }
      }
      mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
      mainContext.automaticallyMergesChangesFromParent = true
      mainContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
      backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
      backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      backgroundContext.parent = mainContext
   }

}
