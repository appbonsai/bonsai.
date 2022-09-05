//
//  bonsaiApp.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.12.2021.
//

import SwiftUI
import RevenueCat
import DotEnv

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
       do {
           let file = try DotEnv.read(path: "/Users/antonhoang/Desktop/bonsai./bonsai/env.text")
           let key = file.lines.first?.value ?? ""
           defer { Purchases.configure(withAPIKey: key) }
       } catch let error {
           print(error.localizedDescription)
       }
   }
    
}
