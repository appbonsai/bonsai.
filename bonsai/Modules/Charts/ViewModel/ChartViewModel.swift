//
//  ChartViewModel.swift
//  bonsai
//
//  Created by Максим Алексеев  on 27.10.2022.
//

import SwiftUI
import CoreData

final class ChartViewModel: ObservableObject {

   @FetchRequest(
      sortDescriptors: [SortDescriptor(\.date)],
      predicate: NSPredicate(
         format: "date >= %@",
         Date().startOfMonth as NSDate
      )
   )
   var transactions: FetchedResults<Transaction>

   func mapToPieChartData() -> PieChartData {
      PieChartData(
         pieChartSlices: transactions.map {
            PieChartSliceData(
               disabledColor: BonsaiColor.ChartDisabledColors.colors.randomElement(),
               color: ($0.category?.color ?? .noCategory).asColor,
               categoryTitle: $0.category?.title ?? L.Category.noCategory,
               icon: $0.category?.image ?? .icon(.star),
               amount: countCategoryAmount(for: $0.category),
               percentages: countPercantage(using: $0.amount),
               pieSlice: nil
            )},
         currentMonthName: Date().currentMonthName
      )
   }


   private func countCategoryAmount(for category: Category?) -> Double {
      Double(
         transactions
            .filter { $0.category == category }
            .map { $0.amount.intValue }
            .reduce(0, +)
      )
   }

   private func countPercantage(using amount: NSDecimalNumber) -> Double {
       let total = transactions
           .map { $0.amount.intValue }
           .reduce(0, +)
       if total != 0 {
           return Double(Int(truncating: amount) * 100 / total)
       } else {
           return .zero
       }
   }

   //    init(mainContext: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
   //        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
   //        let startDate = Date().startOfMonth
   //        let predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
   //        fetchRequest.predicate = predicate
   //        do {
   //            let transactions = try mainContext.fetch(fetchRequest)
   //            self.transactions = transactions
   //        } catch {
   //            print(error)
   //        }
   //    }
   //
   //    init() {
   //        let startDate = Date().startOfMonth
   //        let predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
   //        transactions = FetchRequest(sortDescriptors: [], predicate: predicate)
   //    }
   //    static let mockPieChartData: PieChartData = .init( pieChartSlices: [
   //             .init(color: BonsaiColor.mainPurple, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 100.0, percentages: 15.0),
   //                 .init(color: BonsaiColor.green, categoryTitle: "Travel", icon: Image(systemName: "car.fill"), amount: 280.0, percentages: 15.0),
   //             .init(color: BonsaiColor.pink, categoryTitle: "Fuel", icon: Image(systemName: "ferry.fill"), amount: 400.0, percentages: 15.0),
   //             .init(color: BonsaiColor.blue, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 50.0, percentages: 15.0),
   //             .init(color: BonsaiColor.orange, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 10.0, percentages: 15.0),
   //             .init(color: BonsaiColor.secondary, categoryTitle: "Fuel", icon: Image(systemName: "airplane.departure"), amount: 700.0, percentages: 15.0),
   //             ],
   //                                                           currentMonthName: "December")
   //     }
}
