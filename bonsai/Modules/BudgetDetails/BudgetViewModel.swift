//
//  BudgetViewModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 17/07/2022.
//

import Foundation

protocol BudgetViewModelProtocol {
   var bugdetName: String { get }
   var totalBudget: NSDecimalNumber { get }
   var totalMoneyLeft: NSDecimalNumber { get }
   var totalMoneySpent: NSDecimalNumber { get }
   var budgetDaily: NSDecimalNumber { get }
   var transactions: [Transaction] { get }
}

struct BudgetViewModel: BudgetViewModelProtocol {
   
   private let budgetService: BudgetServiceProtocol
   public private(set) var transactions: [Transaction] = []
   
   init(budgetService: BudgetServiceProtocol, transactions: [Transaction]) {
      self.budgetService = budgetService
      let nonIncomeTransactions = transactions.filter { $0.type != .income }
      self.transactions = nonIncomeTransactions
   }
   
   private var transactionsAmounts: [NSDecimalNumber] {
      transactions.map { $0.amount }
   }
   
   var bugdetName: String {
      budgetService.getBudget()?.name ?? "" 
   }
   
   var totalBudget: NSDecimalNumber {
      budgetService.getTotalBudget() ?? 0
   }
   
   var totalMoneyLeft: NSDecimalNumber {
      budgetService.getTotalMoneyLeft(with: transactionsAmounts) ?? 0
   }
   
   var totalMoneySpent: NSDecimalNumber {
      budgetService.getTotalMoneySpent(with: transactionsAmounts) ?? 0
   }
   
   var budgetDaily: NSDecimalNumber {
      budgetService.getMoneyCanSpendDaily(with: transactionsAmounts) ?? 0
   }
}
