//
//  BudgetModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 17/07/2022.
//

import Foundation

protocol BudgetModelProtocol {
   var bugdetName: String { get }
   var totalBudget: NSDecimalNumber { get }
   var totalMoneyLeft: NSDecimalNumber { get }
   var totalMoneySpent: NSDecimalNumber { get }
   var budgetDaily: NSDecimalNumber { get }
   var dailyPercentDifference: NSDecimalNumber { get }
   var transactions: [Transaction] { get }
}

struct BudgetModel: BudgetModelProtocol {
   
   private let budgetService: BudgetServiceProtocol
   public private(set) var transactions: [Transaction] = []
   
   init(budgetService: BudgetServiceProtocol, transactions: [Transaction]) {
      self.budgetService = budgetService
      self.transactions = transactions
   }
   
   private var transactionsAmounts: [NSDecimalNumber] {
      transactions
         .filter { $0.type != .income }
         .map { $0.amount }
   }
   
   var bugdetName: String {
      budgetService.getBudget()?.name ?? "Budget"
   }
   
   var totalBudget: NSDecimalNumber {
      budgetService.getTotalBudget()
   }
   
   var totalMoneyLeft: NSDecimalNumber {
      budgetService.getTotalMoneyLeft(with: transactionsAmounts)
   }
   
   var totalMoneySpent: NSDecimalNumber {
      budgetService.getTotalMoneySpent(with: transactionsAmounts)
   }
   
   var budgetDaily: NSDecimalNumber {
      budgetService.getMoneyCanSpendDaily(with: transactionsAmounts) 
   }
   
   var dailyPercentDifference: NSDecimalNumber {
      budgetService.getDailyPercentDifference(with: transactionsAmounts)
   }

}
