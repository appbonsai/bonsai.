//
//  SubscriptionModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import Foundation
import RevenueCat

struct Subscription {
    
    let id: String
    let periodName: String
    let fullPrice: String
    let pricePerMonth: String
    let isMostPopular: Bool
    let discount: String
    let isDiscountZero: Bool
    
    init(id: String, periodName: String, fullPrice: String, pricePerMonth: String, isMostPopular: Bool, discount: String, isDiscountZero: Bool) {
        self.id = id
        self.periodName = periodName
        self.fullPrice = fullPrice
        self.pricePerMonth = pricePerMonth
        self.isMostPopular = isMostPopular
        self.discount = discount
        self.isDiscountZero = isDiscountZero
    }
    
    init() {
        self.init(id: "", periodName: "", fullPrice: "", pricePerMonth: "", isMostPopular: false, discount: "", isDiscountZero: false)
    }
}

class SubscriptionViewModel {
    
    public let packages: [Package] 
    
    init(packages: [Package]) {
        self.packages = packages
    }
    
    func createSubscriptions() -> [Subscription] {
        let firstMonthPrice = packages.first(where: {
            $0.storeProduct.subscriptionPeriod?.unit == .month &&
            $0.storeProduct.subscriptionPeriod?.value == 1
        })?
            .storeProduct
            .priceDecimalNumber
        
        let subscriptions: [Subscription] = packages.map {
            pkg in
            
            let storeProduct = pkg.storeProduct
            let productId = storeProduct.productIdentifier
            let periodName = storeProduct.subscriptionPeriod!.periodTitle
            let fullPrice = storeProduct.localizedPriceString
            let pricePerMonthDescription = storeProduct.priceFormatter?.string(from: storeProduct.pricePerMonth ?? .zero) ?? ""
            let isMostPopular = storeProduct.subscriptionPeriod?.unit == .year
            
            guard let firstMonthPrice = firstMonthPrice,
                  let pricePerMonth = storeProduct.pricePerMonth else {
                return Subscription.init()
            }
            
            let discount = pricePerMonth
                .dividing(by: firstMonthPrice)
                .subtracting(1)
                .multiplying(by: 100)
                .round(0)
                .decimalValue
                .magnitude
            
            let discountDescription = String(describing: discount) + "%"
            
            return Subscription(
                id: productId,
                periodName: periodName,
                fullPrice: fullPrice,
                pricePerMonth: pricePerMonthDescription,
                isMostPopular: isMostPopular,
                discount: discountDescription,
                isDiscountZero: discount.isEqual(to: 0))
        }
            
        return subscriptions.sorted(by: { $1.discount < $0.discount })
    }
}
