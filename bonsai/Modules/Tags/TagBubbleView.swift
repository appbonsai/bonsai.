//
//  TagBubbleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 23.01.2022.
//

import SwiftUI

extension TagBubbleView {
   enum Kind {
      case tag (Tag, closeHandler: () -> Void)
      case newTagButton(touchHandler: () -> Void)
   }
}

struct TagBubbleView: View {
   private(set) var kind: Kind

   var body: some View {
      Button(action: {
         if case .newTagButton(let touchHandler) = kind {
            touchHandler()
         }
      }) {
         ZStack {
            BonsaiColor.disabled
            HStack(spacing: 10) {
               Text({ () -> String in
                  switch kind {
                  case .tag(let tag, _):
                     return tag.title
                  case .newTagButton:
                     return "Add Tag  +"
                  }
               }())
                  .font(BonsaiFont.caption_12)
                  .foregroundColor({ () -> Color in
                     switch (kind) {
                     case (.newTagButton):
                        return BonsaiColor.green
                     case (.tag):
                        return BonsaiColor.text
                     }
                  }())
                  .padding([.top, .bottom], 8)
               if case .tag(_, let closeHandler) = kind {
                  Button(action: closeHandler) {
                     BonsaiImage.xMark
                        .renderingMode(.template)
                        .foregroundColor(BonsaiColor.text)
                  }
               }
            } // HStack
            .padding([.leading, .trailing], 8)
         }
      }
   }
}

struct TagBubbleView_Previews: PreviewProvider {
   static var previews: some View {
      TagBubbleView(
         kind: .tag(Tag(
            context: DataController.sharedInstance.container.viewContext,
            title: "Health"
         ), closeHandler: {})
      )
   }
}
