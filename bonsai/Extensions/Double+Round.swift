//
//  Double.swift
//  bonsai
//
//  Created by hoang on 08.01.2022.
//

import Foundation

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
