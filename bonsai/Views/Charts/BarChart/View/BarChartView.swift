//
//  BarChartView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import SwiftUI

struct BarChartView: View {
    // MARK: - Properties
    @State private var currentValue = ""
    @State private var currentLabel = ""
    
    @State private var touchLocation: CGFloat = -1
    
    @ObservedObject var viewModel: BarChartViewModel
    
    // MARK: - View
    var body: some View {
        HStack {
            // left title
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
                
                // bars
                GeometryReader { geo in
                    VStack {
                        HStack(spacing: 12) {
                            ForEach(Array(viewModel.chartData.pieces.enumerated()), id: \.offset) { i, bar in
                                VStack {
                                    BarChartLineView(value: viewModel.normalizedValue(value: bar.value), color: viewModel.chartData.piecesColor)
                                        .scaleEffect(barIsTouched(index: i) ? CGSize(width: 1.3, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                                        .shadow(color: viewModel.chartData.piecesColor.opacity(barIsTouched(index: i) ? 0.5 : 0), radius: 15, x: 0, y: 0)
                                        .animation(.spring())
                                    
                                    Text(bar.label)
                                        .font(BonsaiFont.caption_12)
                                        .foregroundColor(BonsaiColor.text)
                                }
                            }
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { position in
                                    touchLocation = position.location.x/geo.frame(in: .local).width
                                }
                                .onEnded { position in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation(Animation.easeOut(duration: 0.5)) {
                                            touchLocation = -1
                                        }
                                    }
                                }
                        )
                    }
                }
                
                // bottom title
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
    
    // MARK: - Functions
    /// Check if touch location is greater than current bar's beggining and less that next bar's beggining
    func barIsTouched(index: Int) -> Bool {
        touchLocation > CGFloat(index)/CGFloat(viewModel.chartData.pieces.count) && touchLocation < CGFloat(index+1)/CGFloat(viewModel.chartData.pieces.count)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(viewModel: BarChartViewModel())
    }
}
