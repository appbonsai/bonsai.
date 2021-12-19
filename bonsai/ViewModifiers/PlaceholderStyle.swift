//
//  PlaceholderStyle.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12.12.2021.
//

import SwiftUI

struct PlaceholderStyle: ViewModifier {

   public init(
      showPlaceHolder: Bool,
      placeholder: String,
      placeholderColor: Color,
      contentColor: Color,
      placeholderPadding: CGFloat = 0
   ) {
      self.showPlaceHolder = showPlaceHolder
      self.placeholder = placeholder
      self.placeholderColor = placeholderColor
      self.contentColor = contentColor
      self.placeholderPadding = placeholderPadding
   }

   let showPlaceHolder: Bool
   let placeholder: String
   let placeholderColor: Color
   let contentColor: Color
   let placeholderPadding: CGFloat

   func body(content: Content) -> some View {
      ZStack(alignment: .leading) {
         if showPlaceHolder {
            Text(placeholder)
               .foregroundColor(placeholderColor)
               .padding(.leading, placeholderPadding)
         }
         content
            .foregroundColor(contentColor)
      }
   }
}
