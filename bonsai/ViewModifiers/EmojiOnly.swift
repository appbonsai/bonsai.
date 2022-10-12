//
//  EmojiOnly.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12/10/22.
//

import SwiftUI

struct EmojiOnly: ViewModifier {

   @Binding var text: String

   func body(content: Content) -> some View {
      content.onReceive(
         text.publisher.collect(),
         perform: {
            text = String($0.filter(\.isEmoji))
         }
      )
   }
}
