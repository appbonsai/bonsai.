//
//  BarChartViewModel.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import Foundation

final class BarChartViewModel: ObservableObject {
    // MARK: - Properties
    var chartData: BarChartData
    
    // MARK: - Functions
    func normalizedValue(value: Double) -> Double {
        let all = chartData.pieces.map(\.value)
        
        guard let max = all.max() else {
            return 1
        }
        
        if max > 0 && value > 0 {
            return value / Double(max)
        } else if max == 0 {
            return 1
        } else if max > 0 && value < 0 {
            return (100 - abs((value * 100 / max)))/100
        } else /* if max < 0 */ {
            return Double(max) / abs(value)
        }
    }
    
    // MARK: - Init
    init(chartData: BarChartData) {
        self.chartData = chartData
    }
}
