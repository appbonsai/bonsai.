//
//  Appearance.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

enum BonsaiFont {
    static let title_34 = Font.system(size: 34, weight: .bold)
    static let title_28 = Font.system(size: 28, weight: .bold)
    static let title_22 = Font.system(size: 22, weight: .bold)
    static let title_20 = Font.system(size: 20, weight: .bold)
    static let title_headline_17 = Font.system(size: 17, weight: .bold)
    static let body_17 = Font.system(size: 17)
    static let subtitle_15 = Font.system(size: 15, weight: .bold)
    static let body_15 = Font.system(size: 15)
    static let caption_12 = Font.system(size: 12)
    static let caption_11 = Font.system(size: 11)
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
    static let amount = UIImage(systemName: "dollarsign.circle")!.withRenderingMode(.alwaysTemplate)
    static let calendar = UIImage(systemName: "calendar")!
    static let category = UIImage(systemName: "folder")!.withRenderingMode(.alwaysTemplate)
    static let tag = UIImage(systemName: "tag")!
    static let title = UIImage(systemName: "text.bubble")!
    static let arrowUpCircle = UIImage(systemName: "arrow.up.circle")!
    static let chevronForward = Image(systemName: "chevron.forward").renderingMode(.template)
    static let textBubble = Image(systemName: "text.bubble").renderingMode(.template)
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
    static let prompt = Color(hex: 0x686599)
}
