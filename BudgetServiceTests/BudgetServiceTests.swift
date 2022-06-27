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
        let budget = try sut.create(name: "na Tailand", amount: 2000, periodDays: 30)
        // t
        XCTAssertEqual(budget.name, "na Tailand")
        XCTAssertEqual(budget.amount, 2000)
        XCTAssertEqual(budget.periodDays, 30)
    }
    
    func testCreateAndGetBudget() throws {
        // g
        let sut = makeSUT()
        try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        // w
        let budget = try sut.getBudget()
        // t
        XCTAssertNotNil(budget)
    }
    
    func testUpdateBudget() throws {
        // g
        let sut = makeSUT()
        let oldBudget = try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        oldBudget.name = "na Bali"
        oldBudget.amount = 8888
        oldBudget.periodDays = 17
        // w
        try sut.update(budget: oldBudget)
        // t
        XCTAssertEqual(oldBudget.name, "na Bali")
        XCTAssertEqual(oldBudget.amount, 8888)
        XCTAssertEqual(oldBudget.periodDays, 17)
    }
    
    func testDeleteBudget() throws {
        // g
        let sut = makeSUT()
        try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        // w
        try sut.delete()
        let action = { try sut.getBudget() }
        // t
        XCTAssertThrowsError(try action()) { error in
            XCTAssertTrue(error is BudgetService.BudgetDoesntExist)
        }
    }
    
    func testBudgetMoneyLeft() throws {
//        // g
//        let sut = makeSUT()
//        let expectedMoneyLeft: NSDecimalNumber = 222.2
//        // w
//        try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
//        let moneyLeft = try sut.calculateMoneyCanSpendToday()
//        // t
//        XCTAssertEqual(expectedMoneyLeft, moneyLeft)
    }
    
    // Logic update periodDays by time zone
    
    func testBudgetMoneyCanSpendToday() throws {
        // g
        let sut = makeSUT()
        let expectedMoneyCanSpendToday: NSDecimalNumber = 222.2
        try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        // w
        let moneyLeftCanSpend = try sut.calculateMoneyCanSpendToday()
        // t
        XCTAssertEqual(expectedMoneyCanSpendToday, moneyLeftCanSpend)
    }
    
    func testBudgetMoneySpending() throws {
        // g
        let sut = makeSUT()
        let budget = try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        // w
        try sut.calculateAmount(spending: 999)
        // t
        XCTAssertEqual(budget.amount, 9000)
    }
    
    func testBudgetMoneySpendingMoreThanAmountAvailable() throws {
        // g
        let sut = makeSUT()
        try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
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

class BudgetService {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        self.context = context
    }
    
    @discardableResult
    func create(name: String, amount: NSDecimalNumber, periodDays: Int64) throws -> Budget {
        let budget = Budget(
            context: context,
            name: name,
            amount: amount,
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
    
    func update(budget: Budget) throws {
        let request: NSFetchRequest<Budget> = Budget.fetchRequest()
        request.fetchLimit = 1
        let currentBudget = try getBudget()
        currentBudget.setValue(budget.name, forKeyPath: #keyPath(Budget.name))
        currentBudget.setValue(budget.amount, forKeyPath: #keyPath(Budget.amount))
        currentBudget.setValue(budget.periodDays, forKeyPath: #keyPath(Budget.periodDays))
        try context.save()
    }
    
    func delete() throws {
        let currentBudget = try getBudget()
        context.delete(currentBudget)
        try context.save()
    }
    
    func calculateMoneyCanSpendToday() throws -> NSDecimalNumber {
        let currentBudget = try getBudget()
        let diffValue = currentBudget.amount.floatValue / Float(currentBudget.periodDays)
        let moneyCanSpendToday = roundedDecimal(diffValue: diffValue)
        return moneyCanSpendToday
    }
    
    func calculateAmount(spending: NSDecimalNumber) throws {
        let budget = try getBudget()
        if spending.floatValue > budget.amount.floatValue {
            throw BudgetAmountDoesNotEnough()
        }
        let diffValue = (budget.amount.floatValue - spending.floatValue)
        let currentAmount = roundedDecimal(diffValue: diffValue)
        budget.setValue(currentAmount, forKeyPath: #keyPath(Budget.amount))
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
    
    struct BudgetDoesntExist: Error { }
    
    struct BudgetAmountDoesNotEnough: Error { }

}
