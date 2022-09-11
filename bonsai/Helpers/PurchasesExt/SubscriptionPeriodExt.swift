//
//  SubscriptionPeriodExt.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import Foundation
import RevenueCat

extension SubscriptionPeriod {
    var durationTitle: String {
        switch self .unit {
        case .day: return "day"
        case .week: return "week"
        case .month: return "month"
        case .year: return "year"
        @unknown default: return "unknown"
        }
    }
    
    var periodTitle: String {
        let periodString = "\(value) \(durationTitle)"
        let pluralized = value > 1 ? periodString + "s" : periodString
        return pluralized
    }
}
