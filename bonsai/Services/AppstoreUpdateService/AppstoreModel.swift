//
//  AppstoreModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 31/01/2023.
//

import Foundation
import SwiftUI


final class AppstoreModel: ObservableObject {
    
    enum VersionError: Error {
        case invalidBundleInfo, invalidResponse
    }
    
    class LookupResult: Decodable {
        var results: [AppInfo]
    }
    
    class AppInfo: Decodable {
        var version: String
        var trackViewUrl: String
    }
    
    var appURL: String = ""
    var showUpdate: Bool = false
    
    init() {
        _ = getAppInfo { [weak self] appStoreVersion, _ in
            let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            self?.appURL = appStoreVersion?.trackViewUrl ?? ""
            if currentVersion != appStoreVersion?.version {
                self?.showUpdate = true
            } else {
                self?.showUpdate = false
            }
        }
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
}

struct UpdateView: View {
    @State private var showUpdate: Bool
    private var appURL: String = ""
    
    init(appURL: String, showUpdate: Bool) {
        self.appURL = appURL
        self.showUpdate = showUpdate
    }
    
    var body: some View {
        if showUpdate {
            VStack {
                Text("Hey, your app version is outdated")
                    .font(BonsaiFont.title_20)
                    .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    Button(action: {
                        if let appStoreLink = URL(string: appURL) {
                            UIApplication.shared.open(appStoreLink)
                        }
                    }) {
                        Text("Update")
                            .font(BonsaiFont.title_headline_17)
                            .foregroundColor(BonsaiColor.blue)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showUpdate = false
                        }
                    }) {
                        Text("Cancel")
                            .font(BonsaiFont.title_headline_17)
                            .foregroundColor(BonsaiColor.secondary)
                    }
                    Spacer()
                }
                .padding(.top, 4)
            }
            .padding()
            .background(BonsaiColor.card)
            .cornerRadius(10)
        } else {
            EmptyView()
        }
    }
    
}

