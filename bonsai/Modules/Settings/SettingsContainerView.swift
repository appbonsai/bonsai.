//
//  SettingsContainerView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct SettingsContainerView: View {
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().separatorStyle = .none
       UITableView.appearance().backgroundColor = UIColor(BonsaiColor.back)
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
                ForEach(Array(otherRows.enumerated()), id: \.offset) { index, item in
                    Text(item)
                }
            }
            .listRowBackground(BonsaiColor.card)
        }
    }
    
}

struct AppIconChangeRow: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(appIcons.enumerated()), id: \.offset) { index, item in
                    VStack {
                        Image(item)
                            .resizable()
                            .frame(width: 62, height: 62)
                            .scaledToFit()
                        Text("default")
                    }
                }
            }
        }
        .padding([.top, .bottom], 12)
    }
}

struct BackgroundChangeRow: View {
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
                    }
                
                }
            }
        }
        .padding([.top, .bottom], 12)

    }
}

struct OtherSettingsRow: View {
    var body: some View {
        Text("Bonsai premium features")
    }
}


struct SettingsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContainerView()
    }
}

let bgs = ["bonsai_1", "bonsai_2", "bonsai_3", "bonsai_4"]
let appIcons = ["icon-dark", "icon-light", "icon-dark", "icon-light", "icon-dark", "icon-light"]
let otherRows = [
    "Bonsai premium features",
    "Terms of Service",
    "Privacy Policy"
]
