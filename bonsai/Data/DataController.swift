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
    
    private init() {
        UIColorValueTransformer.register()
        UIImageValueTransformer.register()
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
