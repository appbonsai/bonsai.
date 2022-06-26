//
//  DataControllerTests.swift
//  BudgetServiceTests
//
//  Created by antuan.khoanh on 26/06/2022.
//

import CoreData

struct DataControllerMock {

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
