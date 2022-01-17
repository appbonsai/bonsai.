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

   @State private var title: String = ""

   // [color: isSelected]
   @State private var colors: OrderedDictionary<Color, Bool> = [
      BonsaiColor.green: true,
      BonsaiColor.blue: false,
      BonsaiColor.secondary: false,
      BonsaiColor.text: false
   ]

   // [iconName: isSelected]
   @State private var icons = Icon.allCases.reduce(OrderedDictionary<Icon, Bool>())
   { partialResult, icon in
      var res = partialResult
      res[icon] = false
      return res
   }
   
   init() {
      UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()

            VStack {

               Spacer()

                  VStack {

                     LeadingTitleView(text: "Icon")

                     CategoryIconSelectorView(
                        icons: $icons,
                        selectedColor: colors.first { $0.value == true }?.key
                     )
                        .cornerRadius(13)
                        .frame(maxHeight: 180)
                        .padding([.bottom], 16)

                     LeadingTitleView(text: "Color")

                     CategoryColorSelectorView(colors: $colors)
                        .cornerRadius(13)
                        .padding([.bottom], 16)

                     LeadingTitleView(text: "Title")
                     
                     CategoryNewTitleView(
                        title: $title,
                        placeholder: "maximum of 16 symbols"
                     )
                        .cornerRadius(13)
                        .padding([.bottom], 16)
                  } // VStack
                  .padding([.leading, .trailing], 16)

               Spacer()

               Button("Create") {
                  print("create")
               }
               .buttonStyle(PrimaryButtonStyle())
               .padding([.bottom], 16)

            } // VStack
            .frame(maxHeight: .infinity)
         } // ZStack
         .navigationTitle("New category")
      }
   }
}

struct CreateCategoryView_Previews: PreviewProvider {
   static var previews: some View {
      CreateCategoryView()
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
