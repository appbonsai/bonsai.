//
//  DataController.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//

import Foundation
import CoreData
import CloudKit

final class DataController: ObservableObject {
    
    static let sharedInstance = DataController()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "Core")
        let description = NSPersistentStoreDescription()
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.bonsai.tree.app")
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.url = FileManager
            .default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            )
            .first!
            .appendingPathComponent("LocalStore.sqlite")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private init() {
//        container.viewContext.automaticallyMergesChangesFromParent = true
#if DEBUG
        //      do {
        //         // Use the container to initialize the development schema.
        //         try container.initializeCloudKitSchema(options: [])
        //      } catch (let e) {
        //         fatalError(e.localizedDescription)
        //      }
#endif
    }
}
