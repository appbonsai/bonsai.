//
//  AppstoreModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 31/01/2023.
//

import Foundation
import SwiftUI

enum VersionError: Error {
    case invalidBundleInfo, invalidResponse
}

class LookupResult: Decodable {
var results: [AppInfo]
}

class AppInfo: Decodable {
var version: String
var trackViewUrl: String
//let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
// You can add many thing based on "http://itunes.apple.com/lookup?bundleId=\(identifier)"  response
// here version and trackViewUrl are key of URL response
// so you can add all key beased on your requirement.

}

private func getAppInfo(completion: @escaping (AppInfo?, Error?) -> Void) -> URLSessionDataTask? {
    guard let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
          let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
        DispatchQueue.main.async {
            completion(nil, VersionError.invalidBundleInfo)
        }
        return nil
    }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        do {
            if let error = error { throw error }
            guard let data = data else { throw VersionError.invalidResponse }
            
            print("Data:::",data)
            print("response###",response!)
            
            let result = try JSONDecoder().decode(LookupResult.self, from: data)
            
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            
            print("dictionary",dictionary!)
            
            
            guard let info = result.results.first else { throw VersionError.invalidResponse }
            print("result:::",result)
            completion(info, nil)
        } catch {
            completion(nil, error)
        }
    }
    task.resume()
    
    print("task ******", task)
    return task
}

struct UpdateView: View {
    @State private var showUpdate = true
    @State private var appURL: String?

    init(showUpdate: Bool = true, appURL: String) {
        self.showUpdate = showUpdate
        self._appURL = .init(initialValue: appURL)
        checkForUpdate()
    }
    
    var body: some View {
        if showUpdate {
            VStack {
                Text("New Version Available")
                    .font(.headline)
                    .padding()
                Text("A new version of the app is available, tap Update to get the latest version.")
                    .padding()
                Button(action: {
                    if let appStoreLink = URL(string: appURL ?? "") {
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
        getAppInfo { appStoreVersion, _ in
            let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            appURL = .init(appStoreVersion?.trackViewUrl ?? "")
            if currentVersion != appStoreVersion?.version {
                showUpdate = true
            }
        }
    }
}

