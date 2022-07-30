//
//  PieChartView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 29.07.2022.
//

import SwiftUI

struct PieChartView: View {
    @ObservedObject var viewModel: PieChartViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ForEach(viewModel.chartData.pieChartSlices) { slice in
                    PiePieceView(center: CGPoint(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY),
                                 radius: geo.frame(in: .local).width/2,
                                 startDegree: slice.pieSlice?.startDegree ?? 0,
                                 endDegree: slice.pieSlice?.endDegree ?? 0,
                                 isTouched: false,
                                 accentColor: slice.color)
                }
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(viewModel: PieChartViewModel())
    }
}
