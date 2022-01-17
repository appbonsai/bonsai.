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
      LazyHGrid(rows: [GridItem(.flexible())]) {
         ForEach($colors.wrappedValue.keys) { color in
            let isSelected = colors[color] ?? false
            CategoryColorView(
               isSelected: isSelected,
               color: color
            )
               .frame(width: 44, height: 44, alignment: .center)
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
      .padding([.top, .bottom], 8)
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
