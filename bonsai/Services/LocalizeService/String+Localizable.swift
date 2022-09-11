//
//  String+Localizable.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/09/2022.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
