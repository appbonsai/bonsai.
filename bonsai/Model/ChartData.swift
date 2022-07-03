//
//  ChartData.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import Foundation
import SwiftUI

struct ChartData {
    var piecesColor: Color
    var pieces: [ChartPiece]
    var legends: [ChartLegend]
    var bottomTitle: String
    var leftTitle: String
}

/// Data for one piece of chart(one bar, one segment of pie, etc.)
struct ChartPiece: Identifiable {
    var id = UUID() 
    var label: String
    var value: Double
}

struct ChartLegend {
    var color: Color
    var title: String
}
