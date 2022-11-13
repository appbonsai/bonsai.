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

   @Binding var isPresented: Bool
   init(isPresented: Binding<Bool>) {
      self._isPresented = isPresented
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(BonsaiColor.back)
    }
    
    
    private let others: [OtherRows] = [
        .premiumFeature, .termsAndConditions, .privacyPolicy
    ]

    private enum OtherRows: String {
        case premiumFeature
        case termsAndConditions
        case privacyPolicy 
        
        var label: String {
            switch self {
            case .premiumFeature: return L.Bonsai_premium_features
            case .termsAndConditions: return L.Terms_of_Service
            case .privacyPolicy: return L.Privacy_Policy
            }
        }
    }
    
    var body: some View {
       NavigationView {
          List {
             //            Section(header: Text("home background theme")) {
             //                BackgroundChangeRow()
             //            }
             //            .listRowBackground(BonsaiColor.card)
             //            Section(header: Text("app icon")) {
             //                AppIconChangeRow()
             //            }
             //            .listRowBackground(BonsaiColor.card)
             //
             Section(header: Text(L.other)) {
                ForEach(Array(others.enumerated()), id: \.offset) { index, item in
                   HStack {
                      Text(item.label)
                      Spacer()
                   }
                   .contentShape(Rectangle())
                   .onTapGesture {
                      
                      switch others[index] {
                      case .premiumFeature:
                         isPremiumSelected = true
                         
                      case .termsAndConditions:
                         openURL(URL(string: "https://www.craft.do/s/nk6c7jUpWgPhQg")!)
                         
                         
                      case .privacyPolicy:
                         openURL(URL(string: "https://www.craft.do/s/H8euwSq2jDDABJ")!)
                         
                      }
                   }
                }
             }
             
             .listRowBackground(BonsaiColor.card)
          }
          .popover(isPresented: $isPremiumSelected, content: {
             PremiumFeature(isPresented: $isPremiumSelected)
          })
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
             ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                   isPresented = false
                }) {
                   Text(L.cancel)
                      .foregroundColor(BonsaiColor.secondary)
                }
             }
          }
       }
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
       SettingsContainerView(isPresented: .constant(false))
    }
}

let bgs = ["bonsai_1", "bonsai_2", "bonsai_3", "bonsai_4"]
let appIcons = ["icon-dark", "icon-light", "icon-dark", "icon-light", "icon-dark", "icon-light"]


