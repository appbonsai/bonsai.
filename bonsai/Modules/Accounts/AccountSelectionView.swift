//
//  AccountSelectionView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 17.12.2022.
//

import SwiftUI

struct AccountSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedRow: Int = 0
    @EnvironmentObject var languageSettings: LanguageSettings
    
    let accounts: [String] = [
        "Account 1",
        "Account 2"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(Array(accounts.enumerated()), id: \.offset) { index, account in
                            HStack() {
                                Text(account)
                                    .foregroundColor(BonsaiColor.text)
                                    .font(BonsaiFont.title_headline_17)
                                Spacer()
                                
                                VStack(alignment: .leading) {
                                    Text("Net worth:")
                                        .foregroundColor(BonsaiColor.text)
                                        .font(BonsaiFont.caption_12)
                                    Text("327$")
                                        .font(BonsaiFont.title_20)
                                        .foregroundColor(BonsaiColor.text)
                                }
                            }
                            .padding([.vertical, .horizontal], 20)
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
//                        languageSettings.selectedLanguage = availableLanguages[selectedRow]
                        dismiss()
                    }) {
                        Text(LocalizedStringKey("Save_title"))
                            .foregroundColor(BonsaiColor.secondary)
                    }
                }
            }
        } // NavigationView
    }
}




struct AccountSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSelectionView()
    }
}
