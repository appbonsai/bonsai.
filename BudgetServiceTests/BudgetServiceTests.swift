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
    
    func testCreateAndGetBudgetNotNil() throws {
        // g
        let sut = makeSUT()
        // w
        try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        let budget = try sut.getBudget()
        // t
        XCTAssertNotNil(budget)
    }
    
    func testUpdateBudget() throws {
        // g
        let sut = makeSUT()
        // w
        let oldBudget = try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        oldBudget.name = "na Bali"
        oldBudget.amount = 8888
        oldBudget.periodDays = 17
        try sut.update(budget: oldBudget)
        // t
        XCTAssertEqual(oldBudget.name, "na Bali")
        XCTAssertEqual(oldBudget.amount, 8888)
        XCTAssertEqual(oldBudget.periodDays, 17)
    }
    
    func testDeleteBudget() throws {
        // g
        let sut = makeSUT()
        // w
        try sut.create(name: "na Tailand", amount: 9999, periodDays: 45)
        try sut.delete()
        let action = { try sut.getBudget() }
        // t
        XCTAssertThrowsError(try action()) { error in
            XCTAssertTrue(error is BudgetService.BudgetDoesntExist)
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
    }
    
    func delete() throws {
        let currentBudget = try getBudget()
        context.delete(currentBudget)
        try context.save()
    }
    
    struct BudgetDoesntExist: Error { }
    
}
