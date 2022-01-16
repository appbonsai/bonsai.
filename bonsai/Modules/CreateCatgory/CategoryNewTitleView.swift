//
//  CategoryNewTitleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 16.01.2022.
//

import SwiftUI

struct CategoryNewTitleView: View {

   @Binding private(set) var title: String
   private let characterLimit = 16

   var body: some View {
      TextField("", text: $title)
         .modifier(
            CharacterLimit(
               text: $title,
               limit: characterLimit
            )
         )
         .frame(height: 50, alignment: .center)
         .padding([.leading], 16)
         .font(BonsaiFont.body_17)
         .modifier(
            PlaceholderStyle(
               showPlaceHolder: title.isEmpty,
               placeholder: "Title (maximum of 16 symbols)",
               placeholderColor: BonsaiColor.prompt,
               contentColor: BonsaiColor.purple3,
               placeholderPadding: 16
            )
         )
         .background(BonsaiColor.card)
         .cornerRadius(13)
         .padding([.leading, .trailing], 16)
   }
}

struct CategoryNewTitleView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryNewTitleView(title: .constant(""))
   }
}
