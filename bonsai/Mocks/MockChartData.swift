//
//  MockChartData.swift
//  bonsai
//
//  Created by Максим Алексеев  on 26.07.2022.
//

import Foundation

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
}
