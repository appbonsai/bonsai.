//
//  SettingsContainerView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct SettingsContainerView: View {

    @State var isPremiumSelected: Bool = false

    @Environment(\.openURL) var openURL

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(BonsaiColor.back)
    }
    
    
    private let others: [OtherRows] = [
        .premiumFeature, .termsOfService, .privacyPolicy
    ]

    private enum OtherRows: String {
        case premiumFeature = "Bonsai premium features"
        case termsOfService = "Terms of Service"
        case privacyPolicy = "Privacy Policy"
    }
    
    var body: some View {
        List {
            Section(header: Text("home background theme")) {
                BackgroundChangeRow()
            }
            .listRowBackground(BonsaiColor.card)
            Section(header: Text("app icon")) {
                AppIconChangeRow()
            }
            .listRowBackground(BonsaiColor.card)
            
            Section(header: Text("other")) {
                ForEach(Array(others.enumerated()), id: \.offset) { index, item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        switch others[index] {
                        case .premiumFeature:
                            isPremiumSelected = true
                            
                        case .termsOfService:
                            openURL(URL(string: "https://www.google.com")!)


                        case .privacyPolicy:
                            openURL(URL(string: "https://www.apple.com")!)

                        }
                    }
                }
            }
           
            .listRowBackground(BonsaiColor.card)
        }
        .popover(isPresented: $isPremiumSelected, content: {
            PremiumFeature(isPresented: $isPremiumSelected)
        })
    }
    
}

struct AppIconChangeRow: View {
    
    @State var selectedRow: Int = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(appIcons.enumerated()), id: \.offset) { index, item in
                    VStack {
                        Image(item)
                            .resizable()
                            .frame(width: 62, height: 62)
                            .scaledToFit()
                            .overlay(
                               RoundedRectangle(cornerRadius: 13)
                                  .stroke(
                                     BonsaiColor.mainPurple,
                                     lineWidth: selectedRow == index ? 2 : 0
                                  )
                            )
                        Text("default")
                    }
                    .onTapGesture {
                        selectedRow = index
                        let icon = appIcons[index]
                        /*
                         need to change in plist after adding all icons
                         
                         https://www.hackingwithswift.com/example-code/uikit/how-to-change-your-app-icon-dynamically-with-setalternateiconname
                         */
                        UIApplication.shared.setAlternateIconName(icon)
                    }
                }
            }
        }
        .padding([.top, .bottom], 12)
    }
}

struct BackgroundChangeRow: View {
    
    @State var bgSelected: String = bgs.first ?? "bonsai_1"
    @State var selectedRow: Int = 0

    var body: some View {
        VStack {
            Image(bgSelected)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 12)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    
                    ForEach(Array(bgs.enumerated()), id: \.offset) { index, item in
                        VStack {
                            Image(item)
                                .resizable()
                                .frame(width: 80, height: 100)
                                .scaledToFit()
                                .cornerRadius(8)
                            Text("bonsai")
                        }
                        .overlay(
                           RoundedRectangle(cornerRadius: 8)
                              .stroke(
                                 BonsaiColor.mainPurple,
                                 lineWidth: (selectedRow == index) ? 2 : 0
                              )
                        )
                        .onTapGesture {
                            bgSelected = bgs[index]
                            selectedRow = index
                        }
                    }
                
                }
            }
        }
        .padding([.top, .bottom], 12)

    }
}


struct SettingsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContainerView()
    }
}

let bgs = ["bonsai_1", "bonsai_2", "bonsai_3", "bonsai_4"]
let appIcons = ["icon-dark", "icon-light", "icon-dark", "icon-light", "icon-dark", "icon-light"]


