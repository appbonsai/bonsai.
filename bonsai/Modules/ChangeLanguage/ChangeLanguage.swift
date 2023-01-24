//
//  ChangeLanguage.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/12/2022.
//

import SwiftUI

struct ChangeLanguage: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedRow: Int = 0
    @AppUserDefault(.selectedLanguage, defaultValue: nil)
    private var _language: String?
    @EnvironmentObject var languageSettings: LanguageSettings

    let availableLanguages: [Languages] = [
        .uk, .en, .pl, .vi, .ru, .zhHans
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(Array(availableLanguages.enumerated()), id: \.offset) { index, lan in
                            HStack() {
                                Text(LocalizedStringKey(lan.fullnameLanguage))
                                    .foregroundColor(BonsaiColor.text)
                                    .font(BonsaiFont.body_17)
                                Spacer()
                            }
                            .padding([.vertical, .leading], 20)
                            .background(BonsaiColor.card)
                            .cornerRadius(13)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(
                                        BonsaiColor.mainPurple,
                                        lineWidth: selectedRow == index ? 2 : 0
                                    )
                            )
                            .onTapGesture {
                                selectedRow = index
                            }
                            .onAppear {
                                if let defaultLanguage = availableLanguages.firstIndex(where: { $0 == .en }) {
                                    selectedRow = availableLanguages.firstIndex(where: { $0.rawValue == _language }) ?? defaultLanguage
                                }
                            }
                        } // ForEach
                    } // VStack
                    .padding(2)
                } // ScrollView
                .padding(.top, 24)
                .padding(.horizontal, 16)
            } // ZStack
            .navigationTitle(LocalizedStringKey("change.language"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if UserSettings.isChangeLanguageSeen {
                        Button(action: {
                            dismiss()
                        }) {
                            Text(LocalizedStringKey("Cancel_title"))
                                .foregroundColor(BonsaiColor.secondary)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        UserSettings.isChangeLanguageSeen = true
                        languageSettings.selectedLanguage = availableLanguages[selectedRow]
                        dismiss()
                    }) {
                        Text(LocalizedStringKey("Save_title"))
                            .foregroundColor(BonsaiColor.blueLight)
                    }
                }
            }
        } // NavigationView
    }
}

struct ChangeLanguage_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguage()
    }
}
