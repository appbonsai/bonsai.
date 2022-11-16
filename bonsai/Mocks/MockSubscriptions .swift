//
//  MockSubscriptions .swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import Foundation
import SwiftUI

struct MockSubscriptions {
    public static let subscriptions: [Subscription] = [
      .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", trialPrice: "$0", isMostPopular: false, discount: "-2%", isDiscountZero: false),
      .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", trialPrice: "$0", isMostPopular: false,  discount: "-2%", isDiscountZero: false),
      .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", trialPrice: "$0", isMostPopular: false,  discount: "-2%", isDiscountZero: false),
      .init(id: "", periodName: "Lifetime, Pay Once", fullPrice: "4$", pricePerMonth: "2$", trialPrice: "$0", isMostPopular: true, discount: "-2%", isDiscountZero: false),
    ]
}
