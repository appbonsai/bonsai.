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
         category.icon.img
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(
               isSelected
               ? BonsaiColor.mainPurple
               : category.color.color
            )

         Text(category.title)
            .foregroundColor(
               isSelected
               ? BonsaiColor.mainPurple
               : BonsaiColor.text
            )
            .font(
               isSelected
               ? BonsaiFont.title_headline_17
               : BonsaiFont.body_17
            )

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
            color: .red,
            icon: .heart
         )
      )
   }
}
