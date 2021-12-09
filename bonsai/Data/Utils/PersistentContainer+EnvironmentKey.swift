//
//  PersistentContainer+EnvironmentKey.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//

import CoreData
import SwiftUI

private struct PersistentContainerEnvironmentKey: EnvironmentKey {
    static let defaultValue: NSPersistentContainer = DataController.sharedInstance.container
}

extension EnvironmentValues {
    var persistentContainer: NSPersistentContainer {
        get { self[PersistentContainerEnvironmentKey.self] }
        set { self[PersistentContainerEnvironmentKey.self] = newValue }
    }
}
