//
//  Category+Color.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.01.2022.
//

import SwiftUI

extension Category {

   enum Color: String, CaseIterable, Identifiable {
      case green = "green"
      case yellow = "yellow"
      case purple = "purple"
      case blue = "blue"
      case red = "red"
      case white = "white"

      var color: SwiftUI.Color {
         switch self {
         case .green:
            return BonsaiColor.green
         case .yellow:
            return BonsaiColor.orange
         case .purple:
            return BonsaiColor.mainPurple
         case .blue:
            return BonsaiColor.blue
         case .red:
            return BonsaiColor.secondary
         case .white:
            return BonsaiColor.text
         }
      }

      var id: Color { self }
   }
}
