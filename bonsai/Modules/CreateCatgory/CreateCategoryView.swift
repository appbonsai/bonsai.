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
   private let characterLimit = 16

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
               TextField("", text: $title)
                  .modifier(
                     CharacterLimit(
                        text: $title,
                        limit: characterLimit
                     )
                  )
                  .frame(height: 50, alignment: .center)
                  .padding([.leading], 16)
                  .font(BonsaiFont.body_17)
                  .modifier(
                     PlaceholderStyle(
                        showPlaceHolder: title.isEmpty,
                        placeholder: "Title (maximum of 16 symbols)",
                        placeholderColor: BonsaiColor.prompt,
                        contentColor: BonsaiColor.purple3,
                        placeholderPadding: 16
                     )
                  )
                  .background(BonsaiColor.card)
                  .cornerRadius(13)
                  .padding([.leading, .trailing], 16)

               CategoryColorSelectorView(colors: $colors)

               CategoryIconSelectorView(
                  icons: $icons,
                  selectedColor: colors.first(where: { $0.value == true })?.key
               )
                  .padding()

               Button("Create") {
                  print("create")
               }
               .buttonStyle(PrimaryButtonStyle())
            }
            .navigationTitle("New category")
         }
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
