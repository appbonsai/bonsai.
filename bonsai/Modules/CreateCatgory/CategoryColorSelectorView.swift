//
//  CategoryColorSelectorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 14.01.2022.
//

import SwiftUI
import OrderedCollections

struct CategoryColorSelectorView: View {

   @Binding private(set) var colors: OrderedDictionary<Color, Bool>

   var body: some View {
      HStack {
         ForEach($colors.wrappedValue.keys) { color in
            let isSelected = colors[color] ?? false
            CategoryColorView(
               isSelected: isSelected,
               color: color
            )
               .padding(12)
               .onTapGesture {
                  colors.forEach {
                     if $0.key == color {
                        if $0.value == false {
                           colors[$0.key] = true
                        }
                     } else if $0.value == true {
                        colors[$0.key] = false
                     }
                  }
               }
         }
      }
      .frame(maxWidth: .infinity)
      .background(BonsaiColor.card)
   }
}

struct CategoryColorSelectorView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryColorSelectorView(colors: .constant([
         BonsaiColor.green: false,
         BonsaiColor.blue: false,
         BonsaiColor.secondary: false,
         BonsaiColor.text: false
      ]))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
