//
//  CategoryColorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 14.01.2022.
//

import SwiftUI

struct CategoryColorView: View {
   let isSelected: Bool
   let color: Color

   var body: some View {
      ZStack {
         if isSelected {
            Circle()
               .foregroundColor(BonsaiColor.prompt)
               .frame(width: 44, height: 44)
         }
         Circle()
            .foregroundColor(BonsaiColor.card)
            .frame(width: 40, height: 40)
         Circle()
            .foregroundColor(color)
            .frame(width: 36, height: 36)
      }
   }
}

struct CategoryColorView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryColorView(isSelected: true, color: BonsaiColor.green)
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
