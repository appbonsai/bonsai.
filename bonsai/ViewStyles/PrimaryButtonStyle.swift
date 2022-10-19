//
//  PrimaryButtonStyle.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.12.2021.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding()
         .frame(maxWidth: UIScreen.main.bounds.width / 2)
         .foregroundColor(BonsaiColor.card)
         .font(BonsaiFont.title_headline_17)
         .background(BonsaiColor.mainPurple)
         .cornerRadius(13)
   }
}
