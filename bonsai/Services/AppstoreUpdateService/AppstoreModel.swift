//
//  AppstoreModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 31/01/2023.
//

import Foundation
import SwiftUI


func test(completion: @escaping (String) -> Void) {
    let appId = "your app identifier"
    let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
    
    if let url = URL(string: urlString) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let appStoreResponse = try JSONDecoder().decode(AppStoreResponse.self, from: data)
                    let appStoreVersion = appStoreResponse.results.first?.version ?? ""
                    completion(appStoreVersion)
                    // Compare appStoreVersion with the current version installed on the device
                } catch let error {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }
        task.resume()
    }
}


struct AppStoreResponse: Decodable {
    let resultCount: Int
    let results: [AppInfo]
    
    struct AppInfo: Decodable {
        let version: String
    }
}

struct UpdateView: View {
    @State private var showUpdate = false
    
    var body: some View {
        if showUpdate {
            VStack {
                Text("New Version Available")
                    .font(.headline)
                    .padding()
                Text("A new version of the app is available, tap Update to get the latest version.")
                    .padding()
                Button(action: {
                    if let appStoreLink = URL(string: "your app store link") {
                        UIApplication.shared.open(appStoreLink)
                    }
                }) {
                    Text("Update")
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        } else {
            EmptyView()
        }
    }
    
    func checkForUpdate() {
        test { appStoreVersion in
            let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            if currentVersion != appStoreVersion {
                showUpdate = true
            }
        }
    }
}

