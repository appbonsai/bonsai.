//
//  MockSubscriptions .swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import Foundation


struct MockSubscriptions {
    public static let subscriptions: [Subscription] = [
        .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: false, discount: "-2%"),
        .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: false,  discount: "-2%"),
        .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: false,  discount: "-2%"),
        .init(id: "", periodName: "Lifetime, Pay Once", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: true, discount: "-2%"),
    ]
}
