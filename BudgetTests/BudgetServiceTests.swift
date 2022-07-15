//
//  BudgetServiceTests.swift
//  BudgetServiceTests
//
//  Created by antuan.khoanh on 19/06/2022.
//

import XCTest
@testable import bonsai
import CoreData

class BudgetServiceTests: XCTestCase {
    
    func makeSUT() -> BudgetService {
        BudgetService(
            budgetRepository: BudgetRepositoryMock(),
            budgetCalculations: BudgetCalculationsMock())
    }
    
    struct BudgetCalculationsMock: BudgetCalculationsProtocol {
        func calculateMoneyCanSpendToday(currentAmount: NSDecimalNumber, periodDays: Int64) -> NSDecimalNumber {
            fatalError()
        }
        
        func calculateAmount(currentAmount: NSDecimalNumber, spending: NSDecimalNumber) -> NSDecimalNumber? {
            fatalError()
        }
        
        
    }
    
    struct BudgetRepositoryMock: BudgetRepositoryProtocol {
        func create(name: String, totalAmount: NSDecimalNumber, periodDays: Int64) throws -> Budget {
            fatalError()
        }
        
        func getBudget() throws -> Budget {
            fatalError()    
        }
        
        func update(budget: Budget) throws -> Budget {
            fatalError()
        }
        
        func delete() throws {
            fatalError()
        }
        
        
    }
    
}
