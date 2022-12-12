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
   typealias Color = Category.Color
}

struct CreateCategoryView: View {

   @Environment(\.managedObjectContext) private var moc
   @Binding private var isPresented: Bool
   @State private var title: String = ""
   @State /* [color: isSelected] */
   private var colors: OrderedDictionary<Color, Bool>
   @State /* [iconName: isSelected] */
   private var icons: OrderedDictionary<Icon, Bool>
   @State
   private var emojiText: String = ""

   private var completion: ((Category?) -> Void)?
   
   init(isPresented: Binding<Bool>, completion: ((Category?) -> Void)? = nil) {
      self._isPresented = isPresented
      self.completion = completion

      var colors = Color.allCases.reduce(OrderedDictionary<Color, Bool>())
      { partialResult, color in
         var res = partialResult
         res[color] = false
         return res
      }
      if !colors.isEmpty {
         colors.values[0] = true // autoselect first color
      }
      self.colors = colors

      var icons = Icon.allCases.reduce(OrderedDictionary<Icon, Bool>())
      { partialResult, icon in
         var res = partialResult
         res[icon] = false
         return res
      }
      if !icons.isEmpty {
         icons.values[0] = true // autoselect first icon
      }
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
                        gradient: (colors.first(where: \.value)?.key ?? Color.green).asGradient,
                        image: { () -> Category.Image in
                           if emojiText.isEmpty {
                              return (icons.first(where: \.value)?.key).flatMap({ .icon($0) }) ?? .emoji("")
                           } else {
                              return .emoji(emojiText)
                           }
                        }()
                     )
                     .padding([.top], 16)

                     CategoryNewTitleView(
                        title: $title,
                        placeholder: "category.name"
                     )
                     .frame(height: 56, alignment: .center)
                     .background(SwiftUI.Color(hex: 0x3d3c4d))
                     .cornerRadius(13)
                     .padding([.bottom, .leading, .trailing], 16)
                  } // VStack
                  .background(BonsaiColor.card)
                  .cornerRadius(13)

                  CategoryColorSelectorView(colors: $colors)
                     .cornerRadius(13)

                  CategoryIconSelectorView(
                     icons: $icons,
                     emojiText: $emojiText
                  )
                  .cornerRadius(13)

               } // VStack
               .padding([.leading, .trailing], 16)
            } // ScrollView
            .padding(.top, 8)
         } // ZStack
         .navigationTitle(L.Category.new)
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               Button(action: {
                  isPresented = false
                  completion?(nil)
               }) {
                  Text(LocalizedStringKey("Cancel_title"))
                     .foregroundColor(BonsaiColor.secondary)
               }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
               Button(action: {
                  guard let color = colors.first(where: \.value)?.key else {
                     assertionFailure("color was nil, save is not allowed")
                     return
                  }
                  let image: Category.Image
                  if let icon = icons.first(where: \.value)?.key {
                     image = .icon(icon)
                  } else if emojiText.isEmpty == false {
                     image = .emoji(emojiText)
                  } else {
                     assertionFailure("image was nil, save is not allowed")
                     return
                  }
                  
                  let category = Category(
                     context: moc,
                     title: title,
                     color: color,
                     image: image
                  )
                  do {
                     try moc.save()
                  } catch (let e) {
                     assertionFailure(e.localizedDescription)
                  }
                  isPresented = false
                  completion?(category)
               }) {
                  Text(LocalizedStringKey("Done_title"))
                     .if(imageNotSelected == false && title.isEmpty == false, transform: { text in
                        text.foregroundColor(BonsaiColor.secondary)
                     })
               }
               .disabled($title.wrappedValue.isEmpty)
               .disabled(imageNotSelected)
            }
         }
      } // NavigationView
      .interactiveDismissDisabled(true)
   }

   var imageNotSelected: Bool {
      icons.first(where: \.value) == nil && emojiText.isEmpty
   }

   struct CreateCategoryView_Previews: PreviewProvider {
      static var previews: some View {
         CreateCategoryView(isPresented: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
      }
   }
}
