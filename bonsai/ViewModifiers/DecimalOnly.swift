//
//  DecimalOnly.swift
//  bonsai
//
//  Created by Vladimir Korolev on 19.06.2022.
//

import SwiftUI

struct DecimalOnly: ViewModifier {

   @Binding var text: String

   func body(content: Content) -> some View {
      content.onReceive(
         text.publisher.collect(),
         perform: {
            let str = String($0)
            let isNotNumber = str.floatValue == nil
            if isNotNumber {
               text = String(str.dropLast())
            }
         }
      )
   }
}
