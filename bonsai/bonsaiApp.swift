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

   var body: some Scene {
      WindowGroup {
         ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environment(\.persistentContainer, dataController.container)
            .environmentObject(purchaseService)
      }
   }
   
   init() {
      Purchases.logLevel = .debug
      Purchases.configure(withAPIKey: "appl_ccwfbkcrUyDDSxBwwExoLwsgGya")
   }
    
}
