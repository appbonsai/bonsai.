//
//  bonsaiApp.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.12.2021.
//

import SwiftUI

@main
struct bonsaiApp: App {

    @StateObject private var dataController = DataController.sharedInstance

    var body: some Scene {
        WindowGroup {
            TabBar()
        }
    }
}
