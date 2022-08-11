//
//  MockSubscriptions .swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import Foundation


struct MockSubscriptions {
    public static let subscriptions: [Subscription] = [
        .init(periodName: "Monthly", price: "4$", isMostPopular: false),
        .init(periodName: "3 Months", price: "9$", isMostPopular: false),
        .init(periodName: "Annually", price: "$20", isMostPopular: true),
        .init(periodName: "Lifetime, Pay Once", price: "35", isMostPopular: false)
    ]
}
