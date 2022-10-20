//
//  BudgetViewModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 17/07/2022.
//

import Foundation
import CoreData
import SwiftUI

protocol BudgetModelProtocol {
   var bugdetName: String { get }
   var totalBudget: NSDecimalNumber { get }
   var totalMoneyLeft: NSDecimalNumber { get }
   var totalMoneySpent: NSDecimalNumber { get }
   var budgetDaily: NSDecimalNumber { get }
   var transactions: [Transaction] { get }
}

class BudgetModel: ObservableObject, BudgetModelProtocol {
   
   private let budgetService: BudgetServiceProtocol
   public private(set) var transactions: [Transaction] = []
   
   init(budgetService: BudgetServiceProtocol, mainContext: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
      self.budgetService = budgetService
      
      let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
      do {
         let transactions = try mainContext.fetch(fetchRequest)
         self.transactions = transactions
      } catch {
         assertionFailure("Can not fetch transactions")
      }
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
