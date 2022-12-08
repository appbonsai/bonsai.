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
    
    var body: some Scene {
        WindowGroup {
            LanguageManagerView(.deviceLanguage) {
                SplashScreen()
                    .transition(.opacity)
            }
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
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.hex(0x1D1C22)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

