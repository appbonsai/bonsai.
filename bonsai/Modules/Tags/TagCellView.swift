//
//  TagCellView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.06.2022.
//

import SwiftUI

struct TagCellView: View {

   let isSelected: Bool
   let tag: Tag

   var body: some View {
      HStack() {
         Text(tag.title)
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

struct TagCellView_Previews: PreviewProvider {
   static var previews: some View {
      TagCellView(
         isSelected: true,
         tag: .init(
            context: DataController.sharedInstance.container.viewContext,
            title: "Health"
         )
      )
   }
}
