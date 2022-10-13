//
//  BudgetCalculations.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

protocol BudgetCalculationsProtocol {
   // TODO: - bind calculateMoneyCanSpendDaily with timezone or timer or date for user to update daily budget
   func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber
   func calculateTotalMoneyLeft(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber?
   func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber
   func calculateDayLeft(fromDate: Date, toDate: Date) -> Int64
   func calculatePercentDailyDifference(currentDailyBudget: NSDecimalNumber, startDailyBudget: NSDecimalNumber) -> NSDecimalNumber
}

final class BudgetCalculations: BudgetCalculationsProtocol {
   
   func calculatePercentDailyDifference(currentDailyBudget: NSDecimalNumber, startDailyBudget: NSDecimalNumber) -> NSDecimalNumber {
      currentDailyBudget.dividing(by: startDailyBudget).multiplying(by: 100).round()
   }
   
   func calculateMoneyCanSpendDaily(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
      currentAmount.dividing(by: NSDecimalNumber(value: periodDays)).round()
   }
   
   func calculateTotalMoneyLeft(with amount: NSDecimalNumber, after spending: NSDecimalNumber) -> NSDecimalNumber? {
      if spending > amount {
         return nil
      }
      return amount.subtracting(spending).round()
   }
   
   func calculateTotalSpend(transactionAmounts: [NSDecimalNumber]) -> NSDecimalNumber {
      let currentAmount = transactionAmounts
         .reduce(0, { $1.adding($0) })
      return currentAmount.round()
   }
    
    func calculateDayLeft(fromDate: Date, toDate: Date) -> Int64 {
        let dayLeft = Calendar.autoupdatingCurrent.dateComponents([.day], from: fromDate, to: toDate).day ?? 0
        return Int64(dayLeft)
    }
}

