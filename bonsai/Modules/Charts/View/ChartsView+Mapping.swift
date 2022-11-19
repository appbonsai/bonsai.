//
//  ChartsView+Mapping.swift
//  bonsai
//
//  Created by Максим Алексеев  on 30.10.2022.
//

import Foundation
import SwiftUI
import OrderedCollections

extension ChartsView {
    func mapToPieChartData() -> PieChartData {
        var pieChartSliceData: [PieChartSliceData] = []
        transactions
            .filter {$0.date > Date().startOfMonth }
            .filter { $0.category != nil }
            .forEach { transaction in
                if let index = pieChartSliceData.firstIndex(where: { sliceData in
                    sliceData.categoryTitle == transaction.category?.title
                }) {
                    pieChartSliceData[index].amount += transaction.amount.doubleValue
                    pieChartSliceData[index].percentages = countPercantage(using: Int(pieChartSliceData[index].amount))
                } else {
                    pieChartSliceData.append(
                        PieChartSliceData(
                            disabledColor: BonsaiColor.ChartDisabledColors.colors.randomElement(),
                            color: (transaction.category?.color ?? .noCategory).asColor,
                            categoryTitle: (transaction.category?.title ?? L.Category.noCategory),
                            icon: (transaction.category?.image ?? .icon(.noCategory)),
                            amount: transaction.amount.doubleValue,
                            percentages: countPercantage(using: transaction.amount.intValue),
                            pieSlice: nil
                        )
                    )
                }
            }
        
        return PieChartData(
            pieChartSlices: pieChartSliceData,
            currentMonthName: Date().currentMonthName
        )
    }
    
    
    private func countCategoryAmount(for category: Category?) -> Double {
        Double(
            transactions
                .filter { $0.category == category }
                .map { $0.amount.intValue }
                .reduce(0, +)
        )
    }
    
    private func countPercantage(using amount: Int) -> Double {
        let total = transactions
            .filter {$0.date > Date().startOfMonth }
            .filter { $0.type == .expense }
            .map { $0.amount.intValue }
            .reduce(0, +)
        
        return Double(amount * 100 / total)
    }
    
    private func income() -> NSDecimalNumber {
        transactions.reduce(into: [Transaction]()) { partialResult, transaction in
            partialResult.append(transaction)
        }
        .filter { $0.type == .income }
        .map { $0.amount }
        .reduce(0, { partialResult, dec in
            partialResult.adding(dec)
        })
    }
    
    private func expense() -> NSDecimalNumber {
        transactions.reduce(into: [Transaction]()) { partialResult, transaction in
            partialResult.append(transaction)
        }
        .filter { $0.type == .expense }
        .map { $0.amount }
        .reduce(0, { partialResult, dec in
            partialResult.adding(dec)
        })
    }
    
    func mapToBarChartData() -> BarChartData {
        BarChartData(
            piecesColor: BonsaiColor.mainPurple,
            pieces: separateForMonth()
                .map { .init(label: $0.key, value: $0.value) },
            legends: [.init(color: BonsaiColor.mainPurple,
                            title: L.Charts.Legend.balance)],
            bottomTitle: L.Charts.Legend.period,
            leftTitle: L.Charts.Legend.amount(Currency.Validated.current.symbol)
        )
    }
    
    private func separateForMonth() -> OrderedDictionary<String, Double> {
        var dic: OrderedDictionary<String, Double> = [:]
        transactions.forEach {
            dic[$0.date.monthName] = 0
        }
        transactions.forEach {
            if $0.type == .expense {
                dic[$0.date.monthName]? -= Double(truncating: $0.amount)
            } else if $0.type == .income {
                dic[$0.date.monthName]? += Double(truncating: $0.amount)
            }
        }
        return dic
    }
}
