//
//  TagsInputView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 23.01.2022.
//

import SwiftUI
import OrderedCollections

struct TagsInputView: View {
   @Binding private(set) var tags: OrderedSet<Tag>

   var body: some View {
      let cornerRadius: CGFloat = 24

      ZStack {
         BonsaiColor.card
         HStack(spacing: 8) {
            BonsaiImage.tag
               .renderingMode(.template)
               .foregroundColor(BonsaiColor.purple3)
            HStack(spacing: 8) {
               TagBubbleView(kind: .newTagButton(touchHandler: {
                  print("add tag")
               }))
                  .cornerRadius(cornerRadius)
               ForEach(tags) { tag in
                  TagBubbleView(kind: .tag(tag, closeHandler: {
                     tags.remove(tag)
                  })).cornerRadius(cornerRadius)
               } // ForEach
               Spacer()
                  .frame(maxWidth: .infinity)
            } // HStack
         } // HStack
         .padding(16)
      } // ZStack
   }
}

struct TagsInputView_Previews: PreviewProvider {
   static var previews: some View {
      TagsInputView(tags: .constant([Tag(
         context: DataController.sharedInstance.container.viewContext,
         title: "Health"
      )]))
   }
}
