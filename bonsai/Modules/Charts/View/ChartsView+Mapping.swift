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
      PieChartData(
         pieChartSlices:
            transactions
            .filter {$0.date > Date().startOfMonth }
            .map { PieChartSliceData(
               disabledColor: BonsaiColor.ChartDisabledColors.colors.randomElement(),
               color: ($0.category?.color ?? .noCategory).asColor,
               categoryTitle: ($0.category?.title ?? "No Category"),
               icon: ($0.category?.image ?? .icon(.noCategory)),
               amount: countCategoryAmount(for: $0.category),
               percentages: countPercantage(using: $0.amount),
               pieSlice: nil
            )},
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

   private func countPercantage(using amount: NSDecimalNumber) -> Double {
      let total = transactions
         .map { $0.amount.intValue }
         .reduce(0, +)

      return Double(Int(truncating: amount) * 100 / total)
   }

   func income() -> NSDecimalNumber {
      transactions.reduce(into: [Transaction]()) { partialResult, transaction in
         partialResult.append(transaction)
      }
      .filter { $0.type == .income }
      .map { $0.amount }
      .reduce(0, { partialResult, dec in
         partialResult.adding(dec)
      })
   }

   func expense() -> NSDecimalNumber {
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
      BarChartData(piecesColor: BonsaiColor.mainPurple,
                   pieces: separateForMonth().map { .init(label: $0.key, value: $0.value) },
                   legends: [.init(color: BonsaiColor.mainPurple, title: "Balance")],
                   bottomTitle: "Time Period",
                   leftTitle: "Amount ($)")
   }

   func separateForMonth() -> [String: Double] {
      var dic: [String: Double] = [:]
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
   //    static let mockBarChartData: BarChartData = .init(piecesColor: BonsaiColor.mainPurple,
   //                                                       pieces: [.init(label: "Jan", value: 11000),
   //                                                                .init(label: "Feb", value: 5000),
   //                                                                .init(label: "Mar", value: 7999),
   //                                                                .init(label: "Apr", value: 4700),
   //                                                                .init(label: "May", value: 4700),
   //                                                                .init(label: "Jun", value: 4700),
   //                                                                .init(label: "Jul", value: 4700),
   //                                                                .init(label: "Aug", value: 4700),
   //                                                                .init(label: "Sep", value: 4700),
   //                                                               ],
   //                                                       legends: [.init(color: BonsaiColor.mainPurple, title: "Balance")],
   //                                                       bottomTitle: "Time Period",
   //                                                       leftTitle: "Amount ($)")
}
