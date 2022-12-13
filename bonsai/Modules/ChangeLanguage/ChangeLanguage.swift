//
//  ChangeLanguage.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/12/2022.
//

import SwiftUI

struct ChangeLanguage: View {
    
    @Binding var isPresented: Bool
    @State var selectedRow: Int = 0

    let availableLanguages: [Languages] = [
        .uk, .en, .pl, .vi, .ru
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
                    Button(action: {
                        isPresented = false
                    }) {
                        Text(LocalizedStringKey("Cancel_title"))
                            .foregroundColor(BonsaiColor.secondary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text(LocalizedStringKey("Save_title"))
                            .foregroundColor(BonsaiColor.blueLight)
                    }
                }
            }
        } // NavigationView
    }
}


struct ChangeLanguageCellView: View {
    
    let isSelected: Bool
    
    let title: String
    
    var body: some View {
        HStack() {
            Text(LocalizedStringKey(title))
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
                    lineWidth: isSelected ? 2 : 0
                )
        )
        
    }
}

struct ChangeLanguage_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguage(isPresented: .constant(true))
    }
}
