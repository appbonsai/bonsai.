//
//  BudgetServiceTests.swift
//  BudgetServiceTests
//
//  Created by antuan.khoanh on 19/06/2022.
//

import XCTest
@testable import bonsai
import CoreData

// как получаем бюджет
// где его достать

class BudgetServiceTests: XCTestCase {
    
    func testNoBudgetCreated() throws {
        // g
        let sut = makeSUT()
        // w
        let action = { try sut.getBudget() }
        // t
        XCTAssertThrowsError(try action()) { error in
            XCTAssertTrue(error is BudgetService.BudgetDoesntExist)
        }
    }
    
    func testCreateBudget() throws {
        // g
        let sut = makeSUT()
        // w
        let budget = try sut.create(name: "na Tailand", totalAmount: 2000, periodDays: 30)
        // t
        XCTAssertEqual(budget.name, "na Tailand")
        XCTAssertEqual(budget.totalAmount, 2000)
        XCTAssertEqual(budget.periodDays, 30)
    }
    
    func testCreateAndGetBudget() throws {
        // g
        let sut = makeSUT()
        try sut.create(name: "na Tailand", totalAmount: 9999, periodDays: 45)
        // w
        let budget = try sut.getBudget()
        // t
        XCTAssertNotNil(budget)
    }
    
    func testUpdateBudget() throws {
        // g
        let sut = makeSUT()
        let oldBudget = try sut.create(name: "na Tailand", totalAmount: 9999, periodDays: 45)
        oldBudget.name = "na Bali"
        oldBudget.totalAmount = 8888
        oldBudget.periodDays = 17
        // w
        let updated = try sut.update(budget: oldBudget)
        // t
        XCTAssertEqual(updated.name, "na Bali")
        XCTAssertEqual(updated.totalAmount, 8888)
        XCTAssertEqual(updated.periodDays, 17)
    }
    
    func testDeleteBudget() throws {
        // g
        let sut = makeSUT()
        try sut.create(name: "na Tailand", totalAmount: 9999, periodDays: 45)
        // w
        try sut.delete()
        let action = { try sut.getBudget() }
        // t
        XCTAssertThrowsError(try action()) { error in
            XCTAssertTrue(error is BudgetService.BudgetDoesntExist)
        }
    }
        
    func testBudgetMoneyCanSpendToday() throws {
        // g
        let sut = makeSUT()
        let expectedMoneyCanSpendToday: NSDecimalNumber = 222.2
        try sut.create(name: "na Tailand", totalAmount: 9999, periodDays: 45)
        // w
        let moneyLeftCanSpend = try sut.calculateMoneyCanSpendToday()
        // t
        XCTAssertEqual(expectedMoneyCanSpendToday, moneyLeftCanSpend)
    }

  func testBudgetMoneyCanSpendToday2() throws {

    // g

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
      calculateMoney2(
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
        let budget = try sut.create(name: "na Tailand", totalAmount: 9999, periodDays: 45)
        // w
        try sut.calculateAmount(spending: 999)
        // t
        XCTAssertEqual(budget.currentAmount, 9000)
    }
    
    func testBudgetMoneySpendingMoreThanAmountAvailable() throws {
        // g
        let sut = makeSUT()
        try sut.create(name: "na Tailand", totalAmount: 9999, periodDays: 45)
        // w
        let action = { try sut.calculateAmount(spending: 20000) }
        // t
        XCTAssertThrowsError(try action()) { error in
            XCTAssertTrue(error is BudgetService.BudgetAmountDoesNotEnough)
        }
    }
    
    func makeSUT() -> BudgetService {
        let dataController = DataControllerMock()
        return BudgetService(context: dataController.mainContext)
    }

}

func calculateMoney2(currentAmount: Float, periodDays: Int64) -> NSDecimalNumber {
  let diffValue = currentAmount / Float(periodDays)
  let moneyCanSpendToday: NSDecimalNumber = roundedDecimal(diffValue: diffValue)
  return moneyCanSpendToday
}

private func roundedDecimal(diffValue: Float) -> NSDecimalNumber {
    let scale: Int16 = 2
    let behaviour = NSDecimalNumberHandler(
        roundingMode: .plain,
        scale: scale,
        raiseOnExactness: false,
        raiseOnOverflow: false,
        raiseOnUnderflow: false,
        raiseOnDivideByZero: true)
    return NSDecimalNumber(value: diffValue).rounding(accordingToBehavior: behaviour)
}

class BudgetService {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        self.context = context
    }
    
    @discardableResult
    func create(name: String, totalAmount: NSDecimalNumber, periodDays: Int64) throws -> Budget {
        let budget = Budget(
            context: context,
            name: name,
            totalAmount: totalAmount,
            periodDays: periodDays)
        try context.save()
        return budget
    }
    
    func getBudget() throws -> Budget {
        let request: NSFetchRequest<Budget> = Budget.fetchRequest()
        request.fetchLimit = 1
        guard let budget = try context.fetch(request).first else {
            throw BudgetDoesntExist()
        }
        return budget
    }
    
    @discardableResult
    func update(budget: Budget) throws -> Budget {
        let currentBudget = try getBudget()
        currentBudget.setValue(budget.name, forKeyPath: #keyPath(Budget.name))
        currentBudget.setValue(budget.totalAmount, forKeyPath: #keyPath(Budget.totalAmount))
        currentBudget.setValue(budget.periodDays, forKeyPath: #keyPath(Budget.periodDays))
        try context.save()
        return currentBudget
    }
    
    func delete() throws {
        let currentBudget = try getBudget()
        context.delete(currentBudget)
        try context.save()
    }

    func calculateMoneyCanSpendToday() throws -> NSDecimalNumber {
        let currentBudget = try getBudget()
        let diffValue = currentBudget.currentAmount.floatValue / Float(currentBudget.periodDays)
        let moneyCanSpendToday = roundedDecimal(diffValue: diffValue)
        return moneyCanSpendToday
    }
    
    func calculateAmount(spending: NSDecimalNumber) throws {
        let budget = try getBudget()
        if spending.floatValue > budget.currentAmount.floatValue {
            throw BudgetAmountDoesNotEnough()
        }
        let diffValue = (budget.currentAmount.floatValue - spending.floatValue)
        let currentAmount = roundedDecimal(diffValue: diffValue)
        budget.setValue(currentAmount, forKeyPath: #keyPath(Budget.currentAmount))
        try context.save()
    }
    
    private func roundedDecimal(diffValue: Float) -> NSDecimalNumber {
        let scale: Int16 = 2
        let behaviour = NSDecimalNumberHandler(
            roundingMode: .plain,
            scale: scale,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: true)
        return NSDecimalNumber(value: diffValue).rounding(accordingToBehavior: behaviour)
    }
    
    func dailyUpdateBudget() throws -> Budget {
        let budget = try getBudget()
        /*
         https://stackoverflow.com/questions/35284913/swift-countdown-timer-displays-days-hours-seconds-remaining
         */
        return budget
    }
    
    struct BudgetDoesntExist: Error { }
    
    struct BudgetAmountDoesNotEnough: Error { }

}
