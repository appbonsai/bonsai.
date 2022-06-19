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
        XCTFail()
    }
    
    func testBudgetNotEmpty() {
        // g
        let sut = BudgetService()
        // w
        let budget = try? sut.getBudget()
        // t
        XCTAssertNotNil(budget)
    }

}

class BudgetService {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        self.context = context
    }
    
    @discardableResult
    func create(name: String, amount: Decimal, period: Int64) throws -> Budget {
        let budget = Budget(
            context: context,
            name: name,
            amount: amount,
            periodDays: period)
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
