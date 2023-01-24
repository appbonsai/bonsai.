//
//  TitleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12.12.2021.
//

import SwiftUI

struct TitleView: View {

   let title: String
   let image: Image
   @Binding var text: String
   private let characterLimit = 30

   var body: some View {
      HStack(spacing: 8) {
         image
            .foregroundColor(BonsaiColor.purple3)
            .padding([.leading, .top, .bottom], 16)
         TextField("", text: $text)
            .font(BonsaiFont.body_17)
            .foregroundColor(BonsaiColor.purple3)
            .placeholder(
               Text(LocalizedStringKey(title))
                  .foregroundColor(BonsaiColor.prompt),
               show: text.isEmpty
            )
            .modifier(
               CharacterLimit(
                  text: $text,
                  limit: characterLimit
               )
            )
            .padding([.trailing], 16)
      }
      .contentShape(Rectangle())
      .background(BonsaiColor.card)
   }
}

struct TitleView_Previews: PreviewProvider {
   static var previews: some View {
      TitleView(title: "Title", image: BonsaiImage.textBubble, text: .constant(""))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
