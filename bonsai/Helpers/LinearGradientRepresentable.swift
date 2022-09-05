//
//  LinearGradientRepresentable.swift
//  bonsai
//
//  Created by Vladimir Korolev on 14/8/22.
//

import SwiftUI

protocol LinearGradientRepresentable {
   var asGradient: LinearGradient { get }
}

extension Color: LinearGradientRepresentable {
   var asGradient: LinearGradient {
      LinearGradient(
         colors: [self],
         startPoint: .leading,
         endPoint: .trailing
      )
   }
}
