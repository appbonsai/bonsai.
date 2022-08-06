//
//  PackageExt.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import RevenueCat
import Foundation

extension Package {
    func terms(for package: Package) -> String {
        if let intro = package.storeProduct.introductoryDiscount {
            if intro.price == 0 {
                return "\(intro.subscriptionPeriod.periodTitle) free trial"
            } else {
                return "\(package.localizedPriceString) for \(intro.subscriptionPeriod.periodTitle)"
            }
        } else {
            return "Unlocks Premium"
        }
    }
}
