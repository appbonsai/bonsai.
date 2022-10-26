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
    private(set) var chartData: PieChartData
    
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
        
        chartData = .init(pieChartSlices: [], currentMonthName: "")
        setPieSlicesPosition()
        setDisabledColors()
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
    
    private func setDisabledColors() {
        for i in 0..<chartData.pieChartSlices.count {
            chartData.pieChartSlices[i].disabledColor = i > 9 ? BonsaiColor.ChartDisabledColors.colors.randomElement() : BonsaiColor.ChartDisabledColors.colors[i]
        }
    }
    // MARK: - Function
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
    
    func angleAtTouchLocation(inPie pieSize: CGRect, touchLocation: CGPoint) ->  Double?  {
        let dx = touchLocation.x - pieSize.midX
        let dy = touchLocation.y - pieSize.midY
        
        let distanceToCenter = (dx * dx + dy * dy).squareRoot()
        let radius = pieSize.width/2
        guard distanceToCenter <= radius else {
            return nil
        }
        
        let angleAtTouchLocation = Double(atan2(dy, dx) * (180 / .pi))
        if angleAtTouchLocation < 0 {
            return (180 + angleAtTouchLocation) + 180
        } else {
            return angleAtTouchLocation
        }
    }
}
