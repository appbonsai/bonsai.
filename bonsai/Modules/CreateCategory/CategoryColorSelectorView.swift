//
//  CategoryColorSelectorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 14.01.2022.
//

import SwiftUI
import OrderedCollections

struct CategoryColorSelectorView: View {

   @Binding private(set) var colors: OrderedDictionary<Category.Color, Bool>

   private let grid = [
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible())
   ]

   var body: some View {
      LazyVGrid(columns: grid) {
         ForEach($colors.wrappedValue.keys) { color in
            let isSelected = colors[color] ?? false
            CategoryColorView(
               isSelected: isSelected,
               gradient: color.asGradient
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
   static var colors = Category.Color.allCases.reduce(OrderedDictionary<Category.Color, Bool>())
   { partialResult, color in
      var res = partialResult
      res[color] = false
      return res
   }

   static var previews: some View {
      CategoryColorSelectorView(colors: .constant(colors))
         .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
         .previewDisplayName("iPhone 13")
   }
}
