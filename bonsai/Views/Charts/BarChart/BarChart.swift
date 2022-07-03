//
//  BarChart.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import SwiftUI

struct BarChart: View {
    @State private var currentValue = ""
    @State private var currentLabel = ""
    
    @ObservedObject var viewModel: BarChartViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    ForEach(viewModel.chartData.pieces) { bar in
                        BarChartLineView(value: viewModel.normalizedValue(value: bar.value), color: viewModel.chartData.piecesColor)
                    }
                }
            }
        }
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(viewModel: BarChartViewModel())
    }
}
