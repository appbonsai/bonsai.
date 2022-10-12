//
//  CategoryIconView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 16.01.2022.
//

import SwiftUI

struct CategoryIconView: View {
   let isSelected: Bool
   let icon: Image
   let bgColor: Color

   var body: some View {
      ZStack {
         if isSelected {
            Circle()
               .foregroundColor(BonsaiColor.prompt)
               .frame(width: 44, height: 44)
         }
         Circle()
            .foregroundColor(bgColor)
            .frame(width: 40, height: 40)
         icon
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundColor(BonsaiColor.purple5)
            .frame(width: 24, height: 24)
      }
   }
}

struct CategoryIconView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryIconView(
         isSelected: true,
         icon: Category.Icon.gameController.img,
         bgColor: BonsaiColor.card
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
