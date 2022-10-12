//
//  CategoriesCellView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 11.12.2021.
//

import SwiftUI

struct CategoriesCellView: View {

   let isSelected: Bool
   let category: Category

   var body: some View {
      HStack(spacing: 13) {
         switch category.image {
         case let .icon(icon):
            category.color.asGradient
               .frame(width: 22, height: 20)
               .mask(icon.img
                  .resizable()
                  .scaledToFit()
                  .frame(width: 22, height: 20))
         case let .emoji(emoji):
            Text(emoji)
               .font(.system(size: 18))
               .frame(width: 22, height: 20)
         }

         Text(category.title)
            .foregroundColor(BonsaiColor.text)
            .font(BonsaiFont.body_17)

         Spacer()
      }
      .padding([.vertical, .leading], 20)
      .background(BonsaiColor.card)
      .cornerRadius(13)
      .overlay(
         RoundedRectangle(cornerRadius: 13)
            .stroke(
               BonsaiColor.mainPurple,
               lineWidth: isSelected ? 2 : 0
            )
      )

   }
}

struct CategoriesCellView_Previews: PreviewProvider {
   static var previews: some View {
      CategoriesCellView(
         isSelected: true,
         category: .init(
            context: DataController.sharedInstance.container.viewContext,
            title: "Health",
            color: .g4,
            image: .icon(.heart)
         )
      )
   }
}
