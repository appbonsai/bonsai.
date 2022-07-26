//
//  PieChartViewModel.swift
//  bonsai
//
//  Created by Максим Алексеев  on 24.07.2022.
//

import Foundation
import SwiftUI
import CoreData

final class PieChartViewModel: ObservableObject {
    // MARK: - Properties
    private var transactions: [Transaction] = []
    
    init(mainContext: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let startDate = Date().startOfMonth
        // create a predicate to filter between start date and end date
        let predicate = NSPredicate(format: "dateAdded >= %@", startDate as NSDate)
        fetchRequest.predicate = predicate
        do {
            let transactions = try mainContext.fetch(fetchRequest)
            self.transactions = transactions
        } catch {
            print(error)
        }
    }
}
