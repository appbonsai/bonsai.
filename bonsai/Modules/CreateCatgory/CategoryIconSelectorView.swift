//
//  CategoryIconSelectorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 16.01.2022.
//

import SwiftUI
import OrderedCollections

struct CategoryIconSelectorView: View {

   @Binding private(set) var icons: OrderedDictionary<Category.Icon, Bool>
   private(set) var selectedColor: Color?

   private let grid = [
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible())
   ]

   var body: some View {
      ScrollView {
         LazyVGrid(columns: grid) {
            ForEach(icons.keys) { iconName in
               let isSelected = icons[iconName] ?? false
               CategoryIconView(
                  isSelected: isSelected,
                  icon: iconName.img,
                  color: selectedColor ?? BonsaiColor.green
               )
                  .onTapGesture {
                     icons.forEach {
                        if $0.key == iconName {
                           if $0.value == false {
                              icons[$0.key] = true
                           }
                        } else if $0.value == true {
                           icons[$0.key] = false
                        }
                     }
                  }
            }
         }.padding()
      }.background(BonsaiColor.card)
   }
}

struct CategoryIconSelectorView_Previews: PreviewProvider {

   static var icons = Category.Icon.allCases.reduce(OrderedDictionary<Category.Icon, Bool>())
   { partialResult, icon in
      var res = partialResult
      res[icon] = false
      return res
   }

   static var previews: some View {
      CategoryIconSelectorView(
         icons: .constant(icons),
         selectedColor: BonsaiColor.green
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
