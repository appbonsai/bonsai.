//
//  MockChartData.swift
//  bonsai
//
//  Created by Максим Алексеев  on 26.07.2022.
//

import Foundation
import SwiftUI

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


//   case airplane = "airplane.departure"
//   case car = "car.fill"
//   case bus = "bus.fill"
//   case tram = "tram.fill"
//   case ferry = "ferry.fill"
//   case bicycle = "bicycle"
//   case fuel = "fuelpump.fill"
//   case person = "person.fill"
//   case persons = "person.2.fill"
//   case tShirt = "tshirt.fill"
//   case drop = "drop.fill"
//   case pawPrint = "pawprint.fill"
//   case leaf = "leaf.fill"
//   case bag = "bag.fill"
//   case cart = "cart.fill"
//   case creditCard = "creditcard.fill"
//   case heart = "heart.fill"
//   case crossCase = "cross.case.fill"
//   case pills = "pills.fill"
//   case phone = "phone.fill"
//   case books = "books.vertical.fill"
//   case graduationCap = "graduationcap.fill"
//   case ticket = "ticket.fill"
//   case hammer = "hammer.fill"
//   case briefCase = "briefcase.fill"
//   case theaterMasks = "theatermasks.fill"
//   case key = "key.fill"
//   case gameController = "gamecontroller.fill"
//   case paintPalette = "paintpalette.fill"
//   case gift = "gift.fill"
//   case display = "display"
//   case play = "play.fill"
//   case banknote = "banknote.fill"
//   case mic = "mic.fill"
//   case docText = "doc.text.fill"
//   case star = "star.fill"
