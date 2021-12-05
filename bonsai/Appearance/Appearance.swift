//
//  Appearance.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

enum BonsaiColor {
    
    /*
     UIKit 1 column
     */
 
    static let mainPurple = Color(hex: 0x9791FE)
    static let purple2 = Color(hex: 0xA49FFE)
    static let purple3 = Color(hex: 0xB1ACFE)
    static let purple4 = Color(hex: 0xBEBAFE)
    static let purple5 = Color(hex: 0xCBC8FE)
    static let purple6 = Color(hex: 0xD8D6FF)
    static let purple7 = Color(hex: 0xE5E3FF)

    /*
     UIKit 2 column
     */
    static let disabled = Color(hex: 0x1D1C22)
    static let green = Color(hex: 0x34CE8D)
    static let text = Color(hex: 0xE5E3FF)
    
    /*
     UIKit 3 column
     */
    
    static let card = Color(hex: 0x292838)
    static let blue = Color(hex: 0x34A0CE)
    static let blue_dark = Color(hex: 0x0052D4)
    static let pink = Color(hex: 0xC84E89)

    /*
     UIKit 4 column
     */
    static let back = Color(hex: 0x1D1C22)
    static let secondary = Color(hex: 0xF86D70)
    static let blueLight = Color(hex: 0x1FA2FF)
    static let orange = Color(hex: 0xFFE259)

}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
