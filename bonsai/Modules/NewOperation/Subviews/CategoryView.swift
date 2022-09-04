//
//  CategoryView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12.12.2021.
//

import SwiftUI

struct CategoryView: View {

   @Binding var category: Category?

   let iconSizeSide: CGFloat

   var body: some View {
      HStack(spacing: 8) {
         if let category = category {
            categoryView(category)
         } else {
            noCategoryView
         }
         Text(category?.title ?? "Category")
            .foregroundColor(category == nil ? BonsaiColor.prompt : BonsaiColor.purple3)
            .font(BonsaiFont.body_17)
         Spacer()
         BonsaiImage.chevronForward
            .padding([.trailing], 24)
            .foregroundColor(BonsaiColor.purple3)
      }
      .background(BonsaiColor.card)
   }

   private func categoryView(_ category: Category) -> some View {
      category.color.asGradient
         .frame(width: iconSizeSide, height: iconSizeSide)
         .mask(category.icon.img)
         .padding([.leading, .top, .bottom], 16)
   }

   private var noCategoryView: some View {
      BonsaiImage.category
         .foregroundColor(BonsaiColor.purple3)
         .padding([.leading, .top, .bottom], 16)
   }
}

struct CategoryView_Previews: PreviewProvider {
   private static var dataController = DataController.sharedInstance

   static var previews: some View {
      CategoryView(
         category: .constant(
            .init(
               context: DataController.sharedInstance.container.viewContext,
               title: "Health",
               color: .red,
               icon: .gameController
            )
         ), iconSizeSide: 24
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
