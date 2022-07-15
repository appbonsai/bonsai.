//
//  NSNumberDecimalExt.swift
//  bonsai
//
//  Created by antuan.khoanh on 16/07/2022.
//

import Foundation

extension NSDecimalNumber {
    public static func roundedDecimal(diffValue: Float, with scale: Int16 = 2) -> NSDecimalNumber {
        let behaviour = NSDecimalNumberHandler(
            roundingMode: .plain,
            scale: scale,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: true)
        return NSDecimalNumber(value: diffValue).rounding(accordingToBehavior: behaviour)
    }
}
