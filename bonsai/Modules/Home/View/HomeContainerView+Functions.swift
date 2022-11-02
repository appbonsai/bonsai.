//
//  HomeContainerView+Functions.swift
//  bonsai
//
//  Created by Максим Алексеев  on 02.11.2022.
//

import Foundation
import SwiftUI

extension HomeContainerView {
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
    
    func totalBalance() -> Int {
        income().intValue - expense().intValue
    }
    
    func allTransactions() -> [NSDecimalNumber] {
        transactions.map { element -> NSDecimalNumber in
            element.amount
        }
    }
    
    func calculateRevenuePercentage() -> Int {
        let dividend = (income().intValue + expense().intValue)
        return dividend != 0 ? (income().intValue * 100 / dividend) : 0
    }
    
    func calculateExpensePercentage() -> Int {
        let dividend = (income().intValue + expense().intValue)
        return dividend != 0 ? (expense().intValue * 100 / dividend) : 0
    }
    
    func filterTransaction(by categories: [Category]) -> [Transaction] {
        guard let creationDate = budgetService.getBudget()?.createdDate else { return [] }
        return transactions
            .filter { $0.date > creationDate }
            .filter {
                if let category = $0.category {
                    return categories.contains(category)
                } else {
                    return false
                }
            }
    }
}
