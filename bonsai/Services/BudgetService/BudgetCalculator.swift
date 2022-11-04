//
//  BudgetCalculator.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation
import SwiftUI

final class BudgetCalculator: ObservableObject {

   static func spent(
      budget: Budget,
      transactions: any Sequence<Transaction>
   ) -> NSDecimalNumber {
      (
         transactions
            .onlyFromBudget(budget)
            .reduce(into: Decimal.zero) { partialResult, transaction in
               if transaction.type == .expense {
                  partialResult += abs(transaction.amount as Decimal)
               }
            } as NSDecimalNumber
      )
      .round()
   }

   static func left(
      budget: Budget,
      transactions: any Sequence<Transaction>
   ) -> NSDecimalNumber {
      budget.amount
         .subtracting(spent(
            budget: budget,
            transactions: transactions
         ))
         .round()
   }

   static func daily(
      budget: Budget,
      transactions: any Sequence<Transaction>
   ) -> NSDecimalNumber {

      func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
         if periodDays != 0 {
            return currentAmount.dividing(by: NSDecimalNumber(value: periodDays)).round()
         }
         return .zero
      }

      func calculateDayLeft(fromDate: Date, toDate: Date) -> Int64 {
         let dayLeft = Calendar.autoupdatingCurrent.dateComponents([.day], from: fromDate, to: toDate).day ?? 0
         return Int64(dayLeft)
      }

      return calculateMoneyCanSpendDaily(
         currentAmount: left(
            budget: budget,
            transactions: transactions
         ),
         periodDays: budget.periodDays - Int64(calculateDayLeft(
            fromDate: budget.createdDate,
            toDate: .now
         ))
      )
   }

   static func mostExpensiveCategories(
      budget: Budget,
      transactions: some Sequence<Transaction>
   ) -> [Category] {
      let sortedCategories = transactions
         .sorted { $0.amount > $1.amount }
         .compactMap { $0.category }
      if sortedCategories.count > 3 {
         return Array(sortedCategories[0...2])
      } else {
         return sortedCategories
      }
   }
}

extension Sequence where Element == Transaction {
   func onlyFromBudget(_ budget: Budget) -> any Sequence<Transaction> {
      filter { budget.createdDate <= $0.date } // TODO: Period Ends scenario not supported
   }
}
