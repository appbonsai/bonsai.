//
//  PrimaryButtonStyle.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.12.2021.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
       Button(configuration: configuration)
   }

   struct Button: View {
       let configuration: ButtonStyle.Configuration
       @Environment(\.isEnabled) private var isEnabled: Bool
       var body: some View {
           configuration.label
             .padding()
             .frame(maxWidth: UIScreen.main.bounds.width / 2)
             .foregroundColor(BonsaiColor.card)
             .font(BonsaiFont.title_headline_17)
             .background(BonsaiColor.mainPurple)
             .cornerRadius(13)
             .scaleEffect(configuration.isPressed ? 0.9 : 1)
             .opacity(isEnabled ? 1 : 0.5)
       }
   }
}
