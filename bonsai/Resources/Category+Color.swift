//
//  Category+Color.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.01.2022.
//

import SwiftUI

extension Category {

   enum Color: String, CaseIterable, Identifiable, LinearGradientRepresentable {

      case green
      case yellow
      case purple
      case blue
      case red
      case white

      /// gradients
      /// https://github.com/appbonsai/bonsai./issues/52#issuecomment-1214284798

      case g1
      case g2
      case g3
      case g4
      case g5
      case g6
      case g7
      case g8
      case g9

      // MARK: - LinearGradientRepresentable
      
      var asGradient: LinearGradient {
         LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
      }

      // MARK: - Identifiable

      var id: Color { self }

      private var colors: [SwiftUI.Color] {
         switch self {
         case .green:
            return [BonsaiColor.green]
         case .yellow:
            return [BonsaiColor.orange]
         case .purple:
            return [BonsaiColor.mainPurple]
         case .blue:
            return [BonsaiColor.blue]
         case .red:
            return [BonsaiColor.secondary]
         case .white:
            return [BonsaiColor.text]
         case .g1:
            return [.init(hex: 0xE8CBC0), .init(hex: 0x636FA4)]
         case .g2:
            return [.init(hex: 0x3494E6), .init(hex: 0xEC6EAD)]
         case .g3:
            return [.init(hex: 0x67B26F), .init(hex: 0x4CA2CD)]
         case .g4:
            return [.init(hex: 0x0052D4), .init(hex: 0x4364F7), .init(hex: 0x2671C7)]
         case .g5:
            return [.init(hex: 0x1FA2FF), .init(hex: 0x12D8FA), .init(hex: 0x35DBF1)]
         case .g6:
            return [.init(hex: 0x43C6AC), .init(hex: 0xF8FFAE)]
         case .g7:
            return [.init(hex: 0xC84E89), .init(hex: 0xF15F79)]
         case .g8:
            return [.init(hex: 0xFFE259), .init(hex: 0xFFA751)]
         case .g9:
            return [.init(hex: 0xFFAFBD), .init(hex: 0xFFC3A0)]
         }
      }
   }
}
