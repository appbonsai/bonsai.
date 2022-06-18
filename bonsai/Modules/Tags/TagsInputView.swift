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
   let newTagHandler: () -> Void

   private var bubbles: Array<TagBubbleView.Kind> {
      get {
         var arr: [TagBubbleView.Kind] = [.newTagButton(touchHandler: newTagHandler)]
         tags.forEach { tag in
            arr.append(.tag(tag, closeHandler: {
               tags.remove(tag)
            }))
         }
         return arr
      }
   }

   var body: some View {
      ZStack {
         BonsaiColor.card
         HStack(spacing: 8) {
            BonsaiImage.tag
               .renderingMode(.template)
               .foregroundColor(BonsaiColor.purple3)
            FlexibleView(
               data: bubbles,
               spacing: 8,
               alignment: .leading) { item in
                  TagBubbleView(kind: item)
                     .cornerRadius(24)
               }
            Spacer()
         } // HStack
         .padding(16)
      } // ZStack
   }
}

struct TagsInputView_Previews: PreviewProvider {
   static var previews: some View {
      TagsInputView(tags: .constant(
         [Tag(
            context: DataController.sharedInstance.container.viewContext,
            title: "Health"),
          Tag(
            context: DataController.sharedInstance.container.viewContext,
            title: "Sh"
          ),
          Tag(
             context: DataController.sharedInstance.container.viewContext,
             title: "VeryVeryLongNaming")]), newTagHandler: { })
      .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
      .previewDisplayName("iPhone 13")
   }
}
