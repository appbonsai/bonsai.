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
   let trialPrice: String
   let isMostPopular: Bool
   let discount: String
   let isDiscountZero: Bool
}

extension Subscription {

   init?(package: Package, firstMonthPrice: NSDecimalNumber?) {

      let product = package.storeProduct

      guard let firstMonthPrice = firstMonthPrice,
            let pricePerMonth = product.pricePerMonth else {
         return nil
      }

      let discount = pricePerMonth
         .dividing(by: firstMonthPrice)
         .subtracting(1)
         .multiplying(by: 100)
         .round(0)
         .decimalValue
         .magnitude

      self.id = product.productIdentifier
      self.periodName = product.subscriptionPeriod?.periodTitle ?? ""
      self.fullPrice = product.localizedPriceString
      self.pricePerMonth = product.priceFormatter?.string(from: product.pricePerMonth ?? .zero) ?? ""
      self.trialPrice = product.priceFormatter?.string(from: .init(value: 0)) ?? ""
      self.isMostPopular = product.subscriptionPeriod?.unit == .year
      self.discount =  String(describing: discount) + "%"
      self.isDiscountZero = discount.isEqual(to: 0)
   }

}

extension Array where Element == Package {

   var firstMonthPrice: NSDecimalNumber? {
      first {
         $0.storeProduct.subscriptionPeriod?.unit == .month &&
         $0.storeProduct.subscriptionPeriod?.value == 1
      }?
         .storeProduct
         .priceDecimalNumber
   }
}
