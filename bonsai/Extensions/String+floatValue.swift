//
//  String+floatValue.swift
//  bonsai
//
//  Created by Vladimir Korolev on 19.06.2022.
//

import Foundation

extension String {
   struct NumFormatter {
      static let instance = NumberFormatter()
   }

   var floatValue: Float? {
      NumFormatter.instance.number(from: self)?.floatValue
   }
}
