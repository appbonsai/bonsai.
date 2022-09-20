//
//  SettingsContainerView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct SettingsContainerView: View {
    @Binding var selectedIcon: Bool
    @Binding var selectedBackground: Bool
    @State var isPremiumSelected: Bool = false

    @Environment(\.openURL) var openURL

    init(selectedIcon: Binding<Bool>,
         selectedBackground: Binding<Bool>) {
        self._selectedIcon = selectedIcon
        self._selectedBackground = selectedBackground
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
                BackgroundChangeRow(isSelected: selectedBackground)
            }
            .listRowBackground(BonsaiColor.card)
            Section(header: Text("app icon")) {
                AppIconChangeRow(isSelected: selectedIcon)
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
    
    let isSelected: Bool
    
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
                                     lineWidth: isSelected ? 2 : 0
                                  )
                            )
                        Text("default")
                    }
                    .onTapGesture {
                        
                    }
                   
                }
            }
        }
        .padding([.top, .bottom], 12)
    }
}

struct BackgroundChangeRow: View {
    let isSelected: Bool

    var body: some View {
        VStack {
            Image("bonsai_1")
                .resizable()
                .frame(height: 130)
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
                           RoundedRectangle(cornerRadius: 13)
                              .stroke(
                                 BonsaiColor.mainPurple,
                                 lineWidth: isSelected ? 2 : 0
                              )
                        )
                        .onTapGesture {
                            let tap = bgs[index]
                            
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
        SettingsContainerView(selectedIcon: .constant(true), selectedBackground: .constant(true))
    }
}

let bgs = ["bonsai_1", "bonsai_2", "bonsai_3", "bonsai_4"]
let appIcons = ["icon-dark", "icon-light", "icon-dark", "icon-light", "icon-dark", "icon-light"]


