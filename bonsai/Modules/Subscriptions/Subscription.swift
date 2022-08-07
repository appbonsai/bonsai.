//
//  SubscriptionModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import Foundation

struct Subscription {
    let id: String = UUID().uuidString
    let periodName: String
    let price: String
    let isMostPopular: Bool
}
