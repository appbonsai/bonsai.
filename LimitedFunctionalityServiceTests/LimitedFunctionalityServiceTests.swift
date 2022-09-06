//
//  LimitedFunctionalityServiceTests.swift
//  LimitedFunctionalityServiceTests
//
//  Created by antuan.khoanh on 08/09/2022.
//

import XCTest
@testable import bonsai

class LimitedFunctionalityServiceTests: XCTestCase {
    
    var limitedFunctionalityService: LimitedFunctionalityService!

    override func setUpWithError() throws {
        limitedFunctionalityService = LimitedFunctionalityService(purchaseService: PurchaseService())
    }

    override func tearDownWithError() throws {
        limitedFunctionalityService = nil
    }

    func test_checkLimitedTransactions() {
        
        // g
        let input: [Int] = [
            1,2,3,10,20,30
        ]
        
        // w
        let results: [Bool] = input.map {
            limitedFunctionalityService.checkLimitedTransactions(currentCount: $0)
        }
        
        let expectations = [
            false,
            false,
            true,
            true,
            true,
            true
        ]
        
        // t
        for i in 0..<results.count {
            let res = results[i]
            let exp = expectations[i]
            XCTAssertEqual(res, exp)
        }
    }

}
