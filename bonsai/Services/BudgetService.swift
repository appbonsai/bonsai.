//
//  BudgetService.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/07/2022.
//

import Foundation

public final class BudgetService {
    
    private let budgetRepository: BudgetRepositoryProtocol
    private let budgetCalculations: BudgetCalculationsProtocol
     
    init(budgetRepository: BudgetRepositoryProtocol,
         budgetCalculations: BudgetCalculationsProtocol) {
        self.budgetRepository = budgetRepository
        self.budgetCalculations = budgetCalculations
    }
 
    
}

