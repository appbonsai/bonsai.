//
//  Appearance.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

enum BonsaiFont {
    static let title_34 = Font(UIFont.systemFont(ofSize: 34, weight: .init(rawValue: 700)))
    static let title_28 = Font(UIFont.systemFont(ofSize: 28, weight: .init(rawValue: 700)))
    static let title_22 = Font(UIFont.systemFont(ofSize: 22, weight: .init(rawValue: 700)))
    static let title_20 = Font(UIFont.systemFont(ofSize: 20, weight: .init(rawValue: 600)))
    static let title_headline_17 = Font(UIFont.systemFont(ofSize: 17, weight: .init(rawValue: 600)))
    static let body_17 = Font(UIFont.systemFont(ofSize: 17, weight: .init(rawValue: 400)))
    static let subtitle_15 = Font(UIFont.systemFont(ofSize: 15, weight: .init(rawValue: 600)))
    static let body_15 = Font(UIFont.systemFont(ofSize: 15, weight: .init(rawValue: 400)))
    static let caption_12 = Font(UIFont.systemFont(ofSize: 12, weight: .init(rawValue: 400)))
    static let caption_11 = Font(UIFont.systemFont(ofSize: 11, weight: .init(rawValue: 400)))
}

enum BonsaiImage {
    static let crossVialFill = UIImage(systemName: "cross.vial.fill")!
    static let crossVial = UIImage(systemName: "cross.vial")!
    static let forkKnifeCircleFill = UIImage(systemName: "fork.knife.circle.fill")!
    static let forkKnifeCircle = UIImage(systemName: "fork.knife.circle")!
    static let fuelpumpFill = UIImage(systemName: "fuelpump.fill")!
    static let fuelpump = UIImage(systemName: "fuelpump")!
    static let graduationcapCircleFill = UIImage(systemName: "graduationcap.circle.fill")!
    static let graduationcapCircle = UIImage(systemName: "graduationcap.circle")!
    static let pawprintFill = UIImage(systemName: "pawprint.fill")!
    static let amount = UIImage(systemName: "dollarsign.circle")!
    static let calendar = UIImage(systemName: "calendar")!
    static let category = UIImage(systemName: "folder")!
    static let tag = UIImage(systemName: "tag")!
    static let title = UIImage(systemName: "text.bubble")!
}

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
    
    /*
     Not in UIKit
     */
    static let newPurple = Color(hex: 0x6C63FF)
    static let separator = Color(hex: 0x343150)
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
