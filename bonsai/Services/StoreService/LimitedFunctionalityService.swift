//
//  LimitedFunctionalityService.swift
//  bonsai
//
//  Created by antuan.khoanh on 05/09/2022.
//

import Foundation
import Combine
import CoreData
import SwiftUI

class LimitedFunctionalityService {
    var purchaseService: PurchaseService
    var mainContext: NSManagedObjectContext
        
    init(purchaseService: PurchaseService,
         mainContext: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        self.purchaseService = purchaseService
        self.mainContext = mainContext
    }
    
    private func getTransactionsCount() -> Int {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        do {
            let transactions = try mainContext.fetch(fetchRequest)
            return transactions.count
        } catch let error {
            print(error.localizedDescription)
            return 0
        }
    }
    
    func isShowLimitedForTransactions() -> Bool {
        checkLimitedTransactions(currentCount: getTransactionsCount()) && !purchaseService.isSubscriptionActive
    }
    
    func checkLimitedTransactions(currentCount: Int) -> Bool {
        let limitedTransaction = 1
        return currentCount >= limitedTransaction
    }
    
    func checkLimitedSettings() -> Bool {
        purchaseService.isSubscriptionActive
    }
    
    func checkLimitedBudgetPeriodDays() -> Bool { false }
}

/*
 
 1. на хоум экране проверять когда транзакций больше 10 например, то открывать сабскрипшены при свайпе вниз вместо экрана New Operation
 2. на экране настроек чтобы выбрать фон дерева или иконку тоже открывать подписки
 3. при создании бюджета можно выбрать срок бюджета с подпиской можно выбирать количество дней сколько хочешь, а бесплатно без подписки только например создать бюджет сроком на месяц
 */
