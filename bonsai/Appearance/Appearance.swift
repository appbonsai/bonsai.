//
//  Appearance.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

struct BonsaiColor {
    
    /*
     UIKit 1 column
     */
 
    static let lilac1 = Color(hex: "9791FE")
    static let lilac2 = Color(hex: "A49FFE")
    static let lilac3 = Color(hex: "B1ACFE")
    static let lilac4 = Color(hex: "BEBAFE")
    static let lilac5 = Color(hex: "CBC8FE")
    static let lilac6 = Color(hex: "D8D6FF")
    static let lilac7 = Color(hex: "E5E3FF")

    /*
     UIKit 2 column
     */
    static let disabled = Color(hex: "1D1C22")
    static let green = Color(hex: "34CE8D")
    static let text = Color(hex: "E5E3FF")
    
    /*
     UIKit 3 column
     */
    
    static let card = Color(hex: "292838")
    static let blue = Color(hex: "34A0CE")
    
    /*
     UIKit 4 column
     */
    static let back = Color(hex: "1D1C22")
    static let secondary = Color(hex: "F86D70")

}

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

}
