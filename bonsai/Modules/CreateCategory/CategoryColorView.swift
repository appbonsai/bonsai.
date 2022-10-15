//
//  CategoryColorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 14.01.2022.
//

import SwiftUI

struct CategoryColorView: View {
   let isSelected: Bool
   let gradient: LinearGradient

   var body: some View {
      ZStack {
         if isSelected {
            Circle()
               .foregroundColor(BonsaiColor.prompt)
               .frame(width: 44, height: 44)
         }
         gradient
            .frame(width: 36, height: 36)
            .mask(
               Circle()
                  .frame(width: 36, height: 36)
            )
      }
   }
}

struct CategoryColorView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryColorView(isSelected: false, gradient: Category.Color.g2.asGradient)
         .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
         .previewDisplayName("iPhone 13")
   }
}
