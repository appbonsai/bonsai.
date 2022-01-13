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
         Circle() // needed to handle taps from outside
            .foregroundColor(BonsaiColor.back)
            .frame(width: 36, height: 36)
         Circle()
            .if(!isSelected) { circle in
               circle.stroke(lineWidth: 2)
            }
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
