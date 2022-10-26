//
//  ChartData.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import Foundation
import SwiftUI

struct BarChartData {
    var piecesColor: Color
    var pieces: [ChartPiece]
    var legends: [ChartLegend]
    var bottomTitle: String
    var leftTitle: String
}

struct PieChartData {
    var pieChartSlices: [PieChartSliceData]
    /// top title
    var currentMonthName: String
}

struct PieChartSliceData: Identifiable {
    var disabledColor: Color?
    let color: Color
    let categoryTitle: String
    let icon: Image
    let amount: Double
    let percentages: Double
    var pieSlice: PieSlice? 
    let id = UUID()
}

struct PieSlice {
     var startDegree: Double
     var endDegree: Double
}

/// Data for one piece of chart(one bar, one segment of pie, etc.)
struct ChartPiece: Identifiable {
    var id = UUID() 
    var label: String
    var value: Double
}

struct ChartLegend: Identifiable {
    var id = UUID() 
    var color: Color
    var title: String
}
