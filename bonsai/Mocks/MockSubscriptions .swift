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
        .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: false, discount: "-2%", isDiscountZero: false),
        .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: false,  discount: "-2%", isDiscountZero: false),
        .init(id: "", periodName: "Monthly", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: false,  discount: "-2%", isDiscountZero: false),
        .init(id: "", periodName: "Lifetime, Pay Once", fullPrice: "4$", pricePerMonth: "2$", isMostPopular: true, discount: "-2%", isDiscountZero: false),
    ]
}

public struct MockChartData {
    static let mockBarChartData: BarChartData = .init(piecesColor: BonsaiColor.mainPurple,
                                                       pieces: [.init(label: "Jan", value: 11000),
                                                                .init(label: "Feb", value: 5000),
                                                                .init(label: "Mar", value: 7999),
                                                                .init(label: "Apr", value: 4700),
                                                                .init(label: "May", value: 4700),
                                                                .init(label: "Jun", value: 4700),
                                                                .init(label: "Jul", value: 4700),
                                                                .init(label: "Aug", value: 4700),
                                                                .init(label: "Sep", value: 4700),
                                                               ],
                                                       legends: [.init(color: BonsaiColor.mainPurple, title: "Balance")],
                                                       bottomTitle: "Time Period",
                                                       leftTitle: "Amount ($)")

    static let mockPieChartData: PieChartData = .init( pieChartSlices: [
        .init(color: BonsaiColor.mainPurple, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 100.0, percentages: 15.0),
            .init(color: BonsaiColor.green, categoryTitle: "Travel", icon: Image(systemName: "car.fill"), amount: 280.0, percentages: 15.0),
        .init(color: BonsaiColor.pink, categoryTitle: "Fuel", icon: Image(systemName: "ferry.fill"), amount: 400.0, percentages: 15.0),
        .init(color: BonsaiColor.blue, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 50.0, percentages: 15.0),
        .init(color: BonsaiColor.orange, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 10.0, percentages: 15.0),
        .init(color: BonsaiColor.secondary, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 700.0, percentages: 15.0),
        ],
                                                      currentMonthName: "December")
}
