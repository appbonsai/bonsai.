//
//  bonsaiApp.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.12.2021.
//

import SwiftUI
import RevenueCat

@main
struct bonsaiApp: App {
    
    @StateObject private var dataController = DataController.sharedInstance
    @StateObject private var purchaseService = PurchaseService()
    @StateObject private var chartViewModel = ChartViewModel()
    @StateObject private var budgetTreeService = BudgetTreeService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.persistentContainer, dataController.container)
                .environmentObject(purchaseService)
                .environmentObject(chartViewModel)
                .environmentObject(budgetTreeService)
        }
    }
    
    init() {
        Purchases.logLevel = .debug
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist"),
           let keys = NSDictionary(contentsOfFile: path),
           let revenueCatApiKey = keys["revenueCatApiKey"] as? String {
            Purchases.configure(withAPIKey: revenueCatApiKey)
        }

        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}

