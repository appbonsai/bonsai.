//
//  CreateCategoryView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.12.2021.
//

import SwiftUI
import OrderedCollections

fileprivate extension CreateCategoryView {
   typealias Icon = Category.Icon
}

struct CreateCategoryView: View {

   @Binding var isPresented: Bool

   @State private var title: String = ""

   // [color: isSelected]
   @State private var colors: OrderedDictionary<Color, Bool> = [
      BonsaiColor.green: true, // autoselect first color
      Color(hex: 0xFFE259): false,
      Color(hex: 0x9791FE): false,
      BonsaiColor.blue: false,
      BonsaiColor.secondary: false,
      BonsaiColor.text: false
   ]

   // [iconName: isSelected]
   @State private var icons: OrderedDictionary<Icon, Bool>

   @State private var confirmationPresented: Bool = false
   
   init(isPresented: Binding<Bool>) {
      self._isPresented = isPresented

      UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]

      var icons = Icon.allCases.reduce(OrderedDictionary<Icon, Bool>())
      { partialResult, icon in
         var res = partialResult
         res[icon] = false
         return res
      }
      icons.values[0] = true // autoselect first icon
      self.icons = icons
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()

            ScrollView(.vertical) {
               VStack(spacing: 16) {
                  VStack(spacing: 16) {

                     CategoryPreviewView(
                        color: colors.first(where: \.value)?.key ?? BonsaiColor.green,
                        image: icons.first(where: \.value)?.key.img ?? Category.Icon.gameController.img
                     )
                        .padding([.top], 16)

                     CategoryNewTitleView(
                        title: $title,
                        placeholder: "Category Name"
                     )
                        .frame(height: 56, alignment: .center)
                        .background(Color(hex: 0x3d3c4d))
                        .cornerRadius(13)
                        .padding([.bottom, .leading, .trailing], 16)
                  } // VStack
                  .background(BonsaiColor.card)
                  .cornerRadius(13)

                  CategoryColorSelectorView(colors: $colors)
                     .cornerRadius(13)

                  CategoryIconSelectorView(
                     icons: $icons,
                     selectedColor: colors.first(where: \.value)?.key
                  )
                     .cornerRadius(13)

               } // VStack
               .padding([.leading, .trailing], 16)
            } // ScrollView
            .padding(.top, 8)
         } // ZStack
         .navigationTitle("New Category")
         .navigationBarTitleDisplayMode(.inline)
         .navigationBarItems(
            leading:
               Button(action: {
                  confirmationPresented = true
               }) {
                  Text("Cancel")
               }
               .confirmationDialog("Are you sure?", isPresented: $confirmationPresented, actions: {
                  Button("Discard Changes", role: .destructive, action: {
                     isPresented = false
                  })
               }),
            trailing:
               Button(action: {}) {
                  Text("Done")
               }
               .disabled($title.wrappedValue.isEmpty)
         )
      } // NavigationView
   }

   struct CreateCategoryView_Previews: PreviewProvider {
      static var previews: some View {
         CreateCategoryView(isPresented: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
      }
   }
}
