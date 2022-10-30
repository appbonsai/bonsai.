//
//  ChartsView+Mapping.swift
//  bonsai
//
//  Created by Максим Алексеев  on 30.10.2022.
//

import Foundation
import SwiftUI

extension ChartsView {
    func mapToPieChartData() -> PieChartData {
        PieChartData(pieChartSlices: transactions.map { PieChartSliceData(disabledColor: BonsaiColor.ChartDisabledColors.colors.randomElement(),
                                                                          color: $0.category.color.asColor,
                                                                          categoryTitle: $0.category.title,
                                                                          icon: $0.category.image,
                                                                          amount: countCategoryAmount(for: $0.category),
                                                                          percentages: countPercantage(using: $0.amount),
                                                                          pieSlice: nil)},
                     currentMonthName: Date().currentMonthName)
    }
    
    
    private func countCategoryAmount(for category: Category) -> Double {
        Double(
            transactions
                .filter { $0.category == category }
                .map { $0.amount.intValue }
                .reduce(0, +)
        )
    }
    
    private func countPercantage(using amount: NSDecimalNumber) -> Double {
        let total = transactions
            .map { $0.amount.intValue }
            .reduce(0, +)
        
        return Double(Int(truncating: amount) * 100 / total)
    }
}
