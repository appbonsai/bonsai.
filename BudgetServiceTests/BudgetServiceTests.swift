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
            budgetRepository: BudgetRepository(
                context: DataControllerMock().mainContext),
            budgetCalculations: BudgetCalculations())
    }
}
