//
//  BudgetCalculationsTests.swift
//  BudgetServiceTests
//
//  Created by antuan.khoanh on 15/07/2022.
//

import XCTest
@testable import bonsai

class BudgetCalculationsTests: XCTestCase {

    func testBudgetMoneyCanSpendToday() throws {
        // g
        
        let budgetCalculations = makeSUT()
        
        let input: [(amount: NSDecimalNumber, days: Int64)] = [
            (amount: 90, days: 30),
            (amount: 120, days: 30),
            (amount: 30, days: 30),
            (amount: 150, days: 30),
            (amount: 160, days: 30),
            (amount: 880, days: 29)
        ]
        
        // w
        
        let results: [NSDecimalNumber] = input.map {
            budgetCalculations.calculateMoneyCanSpendToday(
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
        
        let input: [(currentAmount: NSDecimalNumber, spending: NSDecimalNumber)] = [
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
            .roundedDecimal(diffValue: 80),
            .roundedDecimal(diffValue: 2527.53),
            .roundedDecimal(diffValue: 1380.52),
            .roundedDecimal(diffValue: 1059.35),
            .roundedDecimal(diffValue: 7820.2)
        ]
        
        for i in 0..<results.count {
            let res = results[i]
            let exp = expectations[i]
            XCTAssertEqual(res, exp)
        }
    }
    
    func testTotalMoneyLeft() {
        // g
        let sut = makeSUT()
        let input: [(total: NSDecimalNumber, currentAmount: NSDecimalNumber)] = [
            (total: 9000, currentAmount: 1234),
            (total: 7890, currentAmount: 4231),
            (total: 923.13, currentAmount: 318.57)
        ]
        
        let expectations: [NSDecimalNumber] = [
            .roundedDecimal(diffValue: 7766),
            .roundedDecimal(diffValue: 3659),
            .roundedDecimal(diffValue: 604.56)
        ]
        // w
        let results: [NSDecimalNumber] = input.map {
            sut.calculateTotalMoneyLeft(
                total: $0.total,
                currentAmount: $0.currentAmount)
        }
        
        // t
        
        for i in 0..<results.count {
            XCTAssertNotNil(expectations[i])
            let res = results[i]
            let exp = expectations[i]
            XCTAssert(res == exp, "res=\(res); exp=\(exp)")
        }
    }
    
    func makeSUT() -> BudgetCalculations {
        BudgetCalculations()
    }
    
}
