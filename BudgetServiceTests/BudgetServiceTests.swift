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
    
    func testBudgetMoneyCanSpendToday() throws {
        // g
        
        let budgetService = makeSUT()
        
        let input: [(amount: Float, days: Int64)] = [
            (amount: 90, days: 30),
            (amount: 120, days: 30),
            (amount: 30, days: 30),
            (amount: 150, days: 30),
            (amount: 160, days: 30),
            (amount: 880, days: 29)
        ]
        
        // w
        
        let results: [NSDecimalNumber] = input.map {
            budgetService.calculateMoneyCanSpendToday(
                currentAmount: $0.amount,
                periodDays: $0.days
            )
        }
        
        // t
        
        let expectations: [NSDecimalNumber] = [
            .init(value: 3),
            .init(value: 4),
            .init(value: 1),
            .init(value: 5),
            .init(value: 5.33),
            .init(value: 30.34)
        ]
        
        for i in 0..<results.count {
            XCTAssertNotNil(expectations[i])
            let res = results[i]
            let exp = expectations[i]
            XCTAssert(res == exp, "res=\(res); exp=\(exp)")
        }
    }
    
    func testBudgetMoneySpending() throws {
        // g
        let sut = makeSUT()
        
        let input: [(currentAmount: Float, spending: NSDecimalNumber)] = [
            (currentAmount: 95, spending: 100),
            (currentAmount: 122, spending: 42),
            (currentAmount: 3032.4, spending: 504.87),
            (currentAmount: 1504.42, spending: 123.9),
            (currentAmount: 1602.56, spending: 543.21),
            (currentAmount: 8808, spending: 987.8)
        ]
        
        // w
        let results: [NSDecimalNumber?] = input.map {
            sut.calculateAmount(
                currentAmount: $0.currentAmount,
                spending: $0.spending)
        }
        
        // t
        
        let expectations: [NSDecimalNumber?] = [
            nil,
            NSDecimalNumber.roundedDecimal(diffValue: 80),
            NSDecimalNumber.roundedDecimal(diffValue: 2527.53),
            NSDecimalNumber.roundedDecimal(diffValue: 1380.52),
            NSDecimalNumber.roundedDecimal(diffValue: 1059.35),
            NSDecimalNumber.roundedDecimal(diffValue: 7820.2)
        ]
        
        for i in 0..<results.count {
            let res = results[i]
            let exp = expectations[i]
            XCTAssertEqual(res, exp)
        }
    }
    
    func makeSUT() -> BudgetService {
        BudgetService(
            budgetRepository: BudgetRepositoryMock(),
            budgetCalculations: BudgetCalculationsMock())
    }
    
    struct BudgetCalculationsMock: BudgetCalculationsProtocol {
        
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
