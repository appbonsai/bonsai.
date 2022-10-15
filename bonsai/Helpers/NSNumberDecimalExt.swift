//
//  NSNumberDecimalExt.swift
//  bonsai
//
//  Created by antuan.khoanh on 16/07/2022.
//

import Foundation

extension NSDecimalNumber {
    public func round(_ scale: Int = 2) -> NSDecimalNumber {
        rounding(
            accordingToBehavior:
                NSDecimalNumberHandler(
                    roundingMode: .plain,
                    scale: Int16(scale),
                    raiseOnExactness: false,
                    raiseOnOverflow: false,
                    raiseOnUnderflow: false,
                    raiseOnDivideByZero: false))
    }
}

extension NSDecimalNumber: Comparable {
    public static func < (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs) == .orderedAscending
    }
    
    public static func > (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs) == .orderedDescending
    }
    
    public static func == (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs) == .orderedSame
    }
}
