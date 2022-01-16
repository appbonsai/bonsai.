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
   let color: Color

   var body: some View {
      ZStack {
         if isSelected {
            Circle()
               .stroke(lineWidth: 2)
               .foregroundColor(color)
               .frame(width: 36, height: 36)
         }
         icon
            .renderingMode(.template)
            .cornerRadius(18)
            .foregroundColor(BonsaiColor.purple5)
            .frame(width: 36, height: 36)
      }
   }
}

struct CategoryIconView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryIconView(
         isSelected: true,
         icon: Category.Icon.gameController.img,
         color: BonsaiColor.green
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
