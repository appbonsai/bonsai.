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
    let container = NSPersistentCloudKitContainer(name: "Core")
    private init() {
        let description = NSPersistentStoreDescription()
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.bonsai.tree.app")
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
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
