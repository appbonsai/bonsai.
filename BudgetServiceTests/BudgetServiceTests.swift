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

    func test() {
        
    }
    
    func testCreateBudget() throws {
        // g
        let sut = makeSUT()
        // w
        let budget = try sut.create(name: "test", amount: 2000, periodDays: 30)
        // t
        XCTAssertEqual(budget.name, "test")
        XCTAssertEqual(budget.amount, 2000)
        XCTAssertEqual(budget.periodDays, 30)
    }
    
    func makeSUT() -> BudgetService {
        let dataController = DataControllerMock()
        return BudgetService(context: dataController.mainContext)
    }
    func testBudgetNotEmpty() {
//        // g
//        let sut = BudgetService()
//        // w
//
//        let budget = sut.create(name: "na Tailand", amount: 2000, period: 30)
//
////        let budget = try? sut.getBudget()
//        // t
//        print("budget", budget)
//        XCTAssertNotNil(budget)
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
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Budget.name))
        guard let budget = try context.fetch(request).first else {
            throw BudgetDoesntExist()
        }
        return budget
    }
    
    struct BudgetDoesntExist: Error { }
}
