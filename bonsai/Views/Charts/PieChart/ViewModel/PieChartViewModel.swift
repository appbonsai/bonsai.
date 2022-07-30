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
    private(set) var categories: [Category] = []
    
    var chartData: PieChartData //{
//        didSet {
//            var slices = [PieSlice]()
//            chartData.pieChartSlices.enumerated().forEach { (i, data) in
//                let value = normalizedValue(index: i, data: self.chartData)
//                if slices.isEmpty {
//                    slices.append((.init(startDegree: 0, endDegree: value * 360)))
//                } else {
//                    slices.append(.init(startDegree: slices.last!.endDegree, endDegree: (value * 360 + slices.last!.endDegree)))
//                }
//                chartData.pieChartSlices[i].pieSlice = slices.last!
//            }
//        }
//    }
    
    var pieSlices: [PieSlice] {
        var slices = [PieSlice]()
        chartData.pieChartSlices.enumerated().forEach {(index, data) in
            let value = normalizedValue(index: index, data: self.chartData)
            if slices.isEmpty {
                slices.append((.init(startDegree: 0, endDegree: value * 360)))
            } else {
                slices.append(.init(startDegree: slices.last!.endDegree, endDegree: (value * 360 + slices.last!.endDegree)))
            }
        }
        return slices
    }
    
    // MARK: - Init
    init(mainContext: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let startDate = Date().startOfMonth
        let predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
        fetchRequest.predicate = predicate
        do {
            let transactions = try mainContext.fetch(fetchRequest)
            self.transactions = transactions
        } catch {
            print(error)
        }
        
        chartData = MockChartData.mockPieChartData
        setPieSlicesPosition()
    }
    
    // MARK: - Private
    private func setPieSlicesPosition() {
        var slices = [PieSlice]()
        chartData.pieChartSlices.enumerated().forEach { (i, data) in
            let value = normalizedValue(index: i, data: self.chartData)
            if slices.isEmpty {
                slices.append((.init(startDegree: 0, endDegree: value * 360)))
            } else {
                slices.append(.init(startDegree: slices.last!.endDegree, endDegree: (value * 360 + slices.last!.endDegree)))
            }
            chartData.pieChartSlices[i].pieSlice = slices.last
        }
    }
    
    // MARK: - Function
    func mapCategoriesToChartData(categories: [Category]) {
        
    }
    
    func getCategories() {
        transactions.forEach {
            categories.append($0.category)
        }
    }
    
    func normalizedValue(index: Int, data: PieChartData) -> Double {
        var total = 0.0
        data.pieChartSlices.forEach { slice in
            total += slice.amount
        }
        return data.pieChartSlices[index].amount / total
    }
}
