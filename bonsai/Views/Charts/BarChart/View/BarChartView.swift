//
//  BarChartView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import SwiftUI

struct BarChartView: View {
    @State private var currentValue = ""
    @State private var currentLabel = ""
    
    @ObservedObject var viewModel: BarChartViewModel
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                
                Text(viewModel.chartData.leftTitle)
                    .font(BonsaiFont.caption_12)
                    .foregroundColor(BonsaiColor.text)
                .rotationEffect(.degrees(-90))
                
                Spacer()
            }

            VStack(alignment: .leading) {
                // legend
                HStack {
                    ForEach(viewModel.chartData.legends) { legend in
                        LegendCellView(legend: legend)
                    }
                }
                .padding(.bottom, 20)
                
                GeometryReader { geo in
                    VStack {
                        HStack(spacing: 12) {
                            ForEach(viewModel.chartData.pieces) { bar in
                                VStack {
                                    BarChartLineView(value: viewModel.normalizedValue(value: bar.value), color: viewModel.chartData.piecesColor)
                                    
                                    Text(bar.label)
                                        .font(BonsaiFont.caption_12)
                                        .foregroundColor(BonsaiColor.text)
                                }
                            }
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Text(viewModel.chartData.bottomTitle)
                        .font(BonsaiFont.caption_12)
                        .foregroundColor(BonsaiColor.text)
                    Spacer()
                }
                .padding(.top, 8)
            }
        }
        .background(BonsaiColor.card)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(viewModel: BarChartViewModel())
    }
}
