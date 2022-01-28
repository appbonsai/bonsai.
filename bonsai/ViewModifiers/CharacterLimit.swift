//
//  CharacterLimit.swift
//  bonsai
//
//  Created by Vladimir Korolev on 14.01.2022.
//

import SwiftUI

struct CharacterLimit: ViewModifier {

   @Binding var text: String
   let limit: Int

   func body(content: Content) -> some View {
      content.onReceive(
         text.publisher.collect(),
         perform: {
            if $0.count > limit {
               text = String($0.prefix(limit))
            }
         }
      )
   }
}
