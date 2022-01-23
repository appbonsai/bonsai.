//
//  TagBubbleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 23.01.2022.
//

import SwiftUI

extension TagBubbleView {
   enum Kind {
      case tag (Tag)
      case newTagButton
   }
}

struct TagBubbleView: View {
   private(set) var kind: Kind

   var body: some View {
      ZStack {
         BonsaiColor.disabled
         HStack(spacing: 10) {
            Text({ () -> String in
               switch kind {
               case .tag(let tag):
                  return tag.title
               case .newTagButton:
                  return "Add Tag  +"
               }
            }())
               .foregroundColor({ () -> Color in
                  switch (kind) {
                  case (.newTagButton):
                     return BonsaiColor.green
                  case (.tag):
                     return BonsaiColor.text
                  }
               }())
            if case .tag = kind {
               BonsaiImage.xMark
                  .renderingMode(.template)
                  .foregroundColor(BonsaiColor.text)
            }
         }
      }
   }
}

struct TagBubbleView_Previews: PreviewProvider {
   static var previews: some View {
      TagBubbleView(
         kind: .tag(
            Tag(
               context: DataController.sharedInstance.container.viewContext,
               title: "Health"
            )
         )
      )
   }
}
