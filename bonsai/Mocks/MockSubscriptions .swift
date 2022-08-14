//
//  MockSubscriptions .swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import Foundation


struct MockSubscriptions {
    public static let subscriptions: [Subscription] = [
      .init(id: "", periodName: "Monthly", price: "4$", isMostPopular: false),
      .init(id: "", periodName: "3 Months", price: "9$", isMostPopular: false),
      .init(id: "", periodName: "Annually", price: "$20", isMostPopular: true),
      .init(id: "", periodName: "Lifetime, Pay Once", price: "35", isMostPopular: false)
    ]
}
