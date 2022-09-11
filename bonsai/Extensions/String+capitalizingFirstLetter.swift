//
//  String+capitalizingFirstLetter.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11/9/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
