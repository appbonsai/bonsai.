//
//  BudgetTreeService.swift
//  bonsai
//
//  Created by Максим Алексеев  on 09.11.2022.
//

import Foundation
import SwiftUI
import CoreData

class BudgetTreeService: ObservableObject {
    enum TreeState {
        case green
        case flowering
        case orange
        case rotting
        case none
        
        var imageName: String? {
            switch self {
            case .green: return "bonsai_green_png"
            case .flowering: return "bonsai_purple_png"
            case .orange: return "bonsai_orange_png"
            case .rotting: return "bonsai_die_png"
            case .none: return nil
            }
        }
    }

    private func calculatePercantage(transactions: [Transaction], budget: Budget) -> Double {
        let budgetTransactions = transactions.filter { $0.date >= budget.createdDate }
        let totalSpent = BudgetCalculator.spent(budget: budget, transactions: budgetTransactions)
        let all = budget.amount
        if all.doubleValue != 0 {
            return totalSpent.doubleValue * 100.0 / all.doubleValue
        } else {
            return .zero
        }
    }
    
    func getTreeState(transactions: [Transaction], budget: Budget) -> TreeState {
        let percentage = calculatePercantage(transactions: transactions, budget: budget)
        if percentage <= 80.0 {
            return .green
        } else if percentage > 80 && percentage <= 90 {
            return .flowering
        } else if percentage > 90 && percentage <= 110 {
            return .orange
        } else if percentage > 110 {
            return .rotting
        } else {
            return .none
        }
    }
}
