//
//  BudgetTests.swift
//  BudgetTests
//
//  Created by hoang on 21.12.2021.
//

import XCTest
@testable import bonsai

class BudgetTests: XCTestCase {

   func test_create_one_budget() throws {
      // g
      let (gateway) = makeSUT()

      // w
      let budget = try gateway.create(name: "North Korea", amount: 2000.0, period: 30)

      // t
      XCTAssertEqual(budget.name, "North Korea")
      XCTAssertEqual(budget.amount, 2000.0)
      XCTAssertEqual(budget.period, 30)
   }

   func test_check_for_empty_budgets() throws {
      // g
      let (gateway) = makeSUT()

      // w
      let budgets = try gateway.getAllBudgets()

      // t
      XCTAssertEqual(budgets.count, 0)
   }

   func test_get_all_budgets() throws {
      // g
      let (gateway) = makeSUT()
      try gateway.create(name: "West Canada", amount: 22000.0, period: 30)
      try gateway.create(name: "North Korea", amount: 70800.0, period: 60)
      try gateway.create(name: "East Canada", amount: 40020.0, period: 70)

      // w
      let budgets = try gateway.getAllBudgets()

      // t
      XCTAssertNotNil(budgets)
      XCTAssertGreaterThan(budgets.count, 0)
      XCTAssertEqual(budgets.count, 3)
   }

   func test_try_to_get_notExist_budget() throws {
      // g
      let (gateway) = makeSUT()
      // w
      let action = { try gateway.getBudget(name: "West Canada") }
      // t
      XCTAssertThrowsError(try action()) { error in
         XCTAssertTrue(error is BudgetGateway.BudgetDoesntExist)
      }
   }

   func test_get_budget_by_name() throws {
      // g
      let gateway = makeSUT()
      try gateway.create(name: "West Canada", amount: 22000.0, period: 30)

      // w
      let budget = try gateway.getBudget(name: "West Canada")
      // t
      XCTAssertEqual(budget.name, "West Canada")
      XCTAssertEqual(budget.amount, 22000.0)
      XCTAssertEqual(budget.period, 30)
   }

   func test_delete_one_budget_while_created_once() throws {
      // g
      let gateway = makeSUT()
      let budget = try gateway.create(name: "West Canada", amount: 22000.0, period: 30)
      // w
      try gateway.delete(budget: budget)
      // t
      XCTAssertEqual(try gateway.getAllBudgets().count, 0)
   }

   func test_delete_one_budget_while_created_two() throws {
      // g
      let gateway = makeSUT()
      let budget1 = try gateway.create(name: "West Canada", amount: 22000.0, period: 30)
      try gateway.create(name: "North Korea", amount: 70800.0, period: 60)
      // w
      try gateway.delete(budget: budget1)
      // t
      XCTAssertEqual(try gateway.getAllBudgets().count, 1)
   }

   func test_delete_two_budget_while_created_two() throws {
      // g
      let gateway = makeSUT()
      let budget1 = try gateway.create(name: "West Canada", amount: 22000.0, period: 30)
      let budget2 = try gateway.create(name: "North Korea", amount: 70800.0, period: 60)
      // w
      try gateway.delete(budget: budget1)
      try gateway.delete(budget: budget2)
      // t
      XCTAssertEqual(try gateway.getAllBudgets().count, 0)
   }

   func test_update_budget() throws {
      // g
      let gateway = makeSUT()
      let budget = try gateway.create(name: "West Canada", amount: 22000.0, period: 30)
      // w
      budget.name = "North Korea"
      budget.amount = 8000.0
      budget.period = 64
      try gateway.update(budget: budget)
      // t
      XCTAssertEqual(budget.name, "North Korea")
      XCTAssertEqual(budget.amount, 8000.0)
      XCTAssertEqual(budget.period, 64)
   }
   
   /*
    **Решение расчета бюджета  по периоду**

    > Spent capacity (*SC) - количество денег которые можно потратить
    >

    > Period (*P) - количество дней периода
    >

    > Amount (*A) - текущая сумма
    >

    > Residue (*R) - остаток от *SC
    >
    1. A / P = (SC)
    2. Если SC в день было потрачено меньше, то (R + A) / P = SC
    3. Если SC в день было потрачено больше, то (А - R) / Р = SC
    */

   func test_spent_capacity_equally_for_all_period_20_days_withAmount_100() throws {
      // g
      let gateway = makeSUT()
      let budget = try gateway.create(name: "West Canada", amount: 100, period: 20)
      // w
      let spentCapacity = try gateway.spentCapacity(budgetName: budget.name)
      // t
      XCTAssertEqual(spentCapacity, 5)
   }

   func test_spent_capacity_equally_for_all_period_30_days_withAmount_60() throws {
      // g
      let gateway = makeSUT()
      let budget = try gateway.create(name: "West Canada", amount: 60, period: 30)
      // w
      let spentCapacity = try gateway.spentCapacity(budgetName: budget.name)
      // t
      XCTAssertEqual(spentCapacity, 2)
   }

   func test_spent_capacity_less_than_available_withAmount98_period_29() throws {
      // g
      let gateway = makeSUT()
      let budget = try gateway.create(name: "West Canada", amount: 100, period: 30)
      // w
      budget.amount = 98
      budget.period = 29
      try gateway.update(budget: budget)
      let spentCapacityLess = try gateway.spentCapacityLessThanAvailable(budget: budget)
      // t
      XCTAssertEqual(budget.amount, 98)
      XCTAssertEqual(budget.period, 29)
      XCTAssertEqual(spentCapacityLess, 3.5)
   }

   func test_spent_capacity_less_than_available_withAmount291_period_29() throws {
      // g
      let gateway = makeSUT()
      let budget = try gateway.create(name: "West Canada", amount: 300, period: 30)
      // w
      budget.amount = 291
      budget.period = 29
      try gateway.update(budget: budget)
      let spentCapacityLess = try gateway.spentCapacityLessThanAvailable(budget: budget)
      // t
      XCTAssertEqual(budget.amount, 291)
      XCTAssertEqual(budget.period, 29)
      XCTAssertEqual(spentCapacityLess, 10.4)
   }

   func test_spent_capacity_more_than_available_withAmount285_period_29() throws {
      // g
      let gateway = makeSUT()
      let budget = try gateway.create(name: "West Canada", amount: 300, period: 30)
      // w
      budget.amount = 285 // 300 - 10 - (10 - 5)
      budget.period = 29
      try gateway.update(budget: budget)
      let spentCapacityLess = try gateway.spentCapacityMoreThanAvailable(budget: budget)
      // t
      XCTAssertEqual(budget.amount, 285)
      XCTAssertEqual(budget.period, 29)
      XCTAssertEqual(spentCapacityLess, 9.5)
   }

   func test_spent_capacity_more_than_available_withAmount270_period_29() throws {
      // g
      let gateway = makeSUT() 
      let budget = try gateway.create(name: "West Canada", amount: 300, period: 30)
      // w
      budget.amount = 270
      budget.period = 29
      try gateway.update(budget: budget)
      let spentCapacityLess = try gateway.spentCapacityMoreThanAvailable(budget: budget)
      // t
      XCTAssertEqual(budget.amount, 270)
      XCTAssertEqual(budget.period, 29)
      XCTAssertEqual(spentCapacityLess, 9.0)
   }

   typealias SUT = (BudgetGateway)

   func makeSUT() -> SUT {
      let dataControllerTest = DataControllerTests()
      return BudgetGateway(mainContext: dataControllerTest.mainContext)
   }

}
