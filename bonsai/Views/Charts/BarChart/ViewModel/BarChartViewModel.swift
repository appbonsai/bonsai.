//
//  BarChartViewModel.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import Foundation

class BarChartViewModel: ObservableObject {
    // MARK: - Properties
    private let mockChartData: ChartData = .init(piecesColor: BonsaiColor.mainPurple,
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
    var chartData: ChartData
    
    // MARK: - Functions
    func normalizedValue(value: Double) -> Double {
             var allValues: [Double]    {
                 var values = [Double]()
//                 for data in data {
//                     values.append(data.value)
//                 }
                 for piece in chartData.pieces {
                     values.append(piece.value)
                 }
                 return values
             }
             guard let max = allValues.max() else {
                 return 1
             }
        
             if max != 0 {
                 return value/Double(max)
             } else {
                 return 1
             }
    }
    
    // MARK: - Init
    init() {
        chartData = mockChartData
    }
}
