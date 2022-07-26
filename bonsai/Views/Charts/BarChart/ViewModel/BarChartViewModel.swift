//
//  BarChartViewModel.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import Foundation

final class BarChartViewModel: ObservableObject {
    // MARK: - Properties
    var chartData: BarChartData?
    
    // MARK: - Functions
    func normalizedValue(value: Double) -> Double {
        var allValues: [Double]    {
            var values = [Double]()
            guard let chartData = chartData else {
                return []
            }

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
//        chartData = MockChartData.mockBarChartData
    }
}
