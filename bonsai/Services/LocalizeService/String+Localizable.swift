//
//  String+Localizable.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/09/2022.
//

import Foundation

extension String {
   func localized(args: [String] = []) -> String {
      let localizedString = NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
      if args.isEmpty == false {
         return String(format: localizedString, "7")
      }
      return localizedString
    }
}
