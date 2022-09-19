//
//  CloudKitController.swift
//  bonsai
//
//  Created by antuan.khoanh on 19/09/2022.
//

import Foundation
import CloudKit
import CoreData

final class CloudKitController: ObservableObject  {
    static let sharedInstance = CloudKitController()
    let container = NSPersistentCloudKitContainer(name: "bonsai")
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

}
