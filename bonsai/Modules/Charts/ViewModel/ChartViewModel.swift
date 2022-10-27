//
//  ChartViewModel.swift
//  bonsai
//
//  Created by Максим Алексеев  on 27.10.2022.
//

import SwiftUI
import CoreData

final class ChartViewModel: ObservableObject {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>

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
    
    func countCategoryAmount(for category: Category) -> Double {
        Double(
            transactions
            .filter { $0.category == category }
            .map { $0.amount.intValue }
            .reduce(0, +)
        )
    }
    
    func countPercantage(using amount: NSDecimalNumber) -> Double {
        let total = transactions
            .map { $0.amount.intValue }
            .reduce(0, +)
        
        return Double(Int(truncating: amount) * 100 / total)
        // total = 100
        // amount = X
    }

    
//    static let mockPieChartData: PieChartData = .init( pieChartSlices: [
//             .init(color: BonsaiColor.mainPurple, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 100.0, percentages: 15.0),
//                 .init(color: BonsaiColor.green, categoryTitle: "Travel", icon: Image(systemName: "car.fill"), amount: 280.0, percentages: 15.0),
//             .init(color: BonsaiColor.pink, categoryTitle: "Fuel", icon: Image(systemName: "ferry.fill"), amount: 400.0, percentages: 15.0),
//             .init(color: BonsaiColor.blue, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 50.0, percentages: 15.0),
//             .init(color: BonsaiColor.orange, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 10.0, percentages: 15.0),
//             .init(color: BonsaiColor.secondary, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 700.0, percentages: 15.0),
//             ],
//                                                           currentMonthName: "December")
//     }
}
