//
//  CategoryView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12.12.2021.
//

import SwiftUI

struct CategoryView: View {

   @Binding var category: Category?

   var body: some View {
      HStack(spacing: 8) {
         (category?.icon.img ?? Image(uiImage: BonsaiImage.category))
            .foregroundColor(category.flatMap { $0.color.color } ?? BonsaiColor.purple3)
            .padding([.leading, .top, .bottom], 16)
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
         )
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
