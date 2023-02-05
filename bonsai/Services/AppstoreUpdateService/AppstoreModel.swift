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
        _ = getAppInfo { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let info):
                let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                self.appURL = info.trackViewUrl
                self.showUpdate = currentVersion != info.version
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAppInfo(completion: @escaping (Result<AppInfo, Error>) -> Void) -> URLSessionDataTask? {
        guard let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            DispatchQueue.main.async {
                completion(.failure(VersionError.invalidBundleInfo))
            }
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(VersionError.invalidResponse))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(LookupResult.self, from: data)
                    guard let info = result.results.first else {
                        completion(.failure(VersionError.invalidResponse))
                        return
                    }
                    completion(.success(info))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
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

