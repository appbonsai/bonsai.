//
//  CategoryNewTitleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 16.01.2022.
//

import SwiftUI

struct CategoryNewTitleView: View {

   @Binding private(set) var title: String
   let placeholder: String
   private let characterLimit = 16

   var body: some View {
      TextField("", text: $title)
         .font(BonsaiFont.title_22)
         .foregroundColor(BonsaiColor.purple3)
         .multilineTextAlignment(.center)
         .modifier(
            CharacterLimit(
               text: $title,
               limit: characterLimit
            )
         )
         .placeholder(
            Text(placeholder)
               .font(BonsaiFont.title_22)
               .foregroundColor(BonsaiColor.prompt)
               .frame(maxWidth: .infinity, alignment: .center)
               .multilineTextAlignment(.center),
            show: title.isEmpty
         )
   }
}

struct CategoryNewTitleView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryNewTitleView(
         title: .constant(""),
         placeholder: "Title"
      )
   }
}
