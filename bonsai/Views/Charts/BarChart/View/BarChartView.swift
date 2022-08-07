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
            if let leftTitle = viewModel.chartData?.leftTitle {
                Text(leftTitle)
                    .font(BonsaiFont.caption_12)
                    .foregroundColor(BonsaiColor.text)
                    .rotated()
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading) {
                // legend
                HStack {
                    if let legends = viewModel.chartData?.legends {
                        ForEach(legends) { legend in
                            LegendCellView(legend: legend)
                        }
                        .padding(.bottom, 20)
                    }
                }
                
                GeometryReader { geo in
                    VStack {
                        if let piecesColor = viewModel.chartData?.piecesColor, !currentLabel.isEmpty {
                            BarDetailLabel(title: currentValue, color: piecesColor)
                                .offset(x: labelOffset(in: geo.frame(in: .local).width))
                                .animation(.easeIn)
                                .padding(.bottom, 10)
                        }
                        
                        // bars
                        HStack(spacing: 10) {
                            if let chartData = viewModel.chartData {
                                
                                ForEach(Array(chartData.pieces.enumerated()), id: \.offset) { i, bar in
                                    VStack {
                                        BarChartLineView(value: viewModel.normalizedValue(value: bar.value), color: chartData.piecesColor)
                                            .scaleEffect(barIsTouched(index: i) ? CGSize(width: 1.3, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                                            .shadow(color: chartData.piecesColor.opacity(barIsTouched(index: i) ? 0.5 : 0), radius: 15, x: 0, y: 0)
                                            .animation(.spring())
                                        
                                        Text(bar.label)
                                            .font(BonsaiFont.caption_12)
                                            .foregroundColor(BonsaiColor.text)
                                    }
                                }
                            }
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { position in
                                    touchLocation = position.location.x/geo.frame(in: .local).width
                                    updateCurrentValue()
                                }
                                .onEnded { position in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        withAnimation(Animation.easeOut(duration: 0.5)) {
                                            touchLocation = -1
                                            currentValue  =  ""
                                            currentLabel = ""
                                        }
                                    }
                                }
                        )
                    }
                }
                
                
                // bottom title
                HStack {
                    Spacer()
                    
                    if let bottomTitle = viewModel.chartData?.bottomTitle {
                        Text(bottomTitle)
                            .font(BonsaiFont.caption_12)
                            .foregroundColor(BonsaiColor.text)
                    }
                    Spacer()
                }
                .padding(.top, 8)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 10)
        .background(BonsaiColor.card)
    }
    
    // MARK: - Functions
    /// Check if touch location is greater than current bar's beggining and less that next bar's beggining
    func barIsTouched(index: Int) -> Bool {
        guard let chartData = viewModel.chartData else { return false }
        return touchLocation > CGFloat(index)/CGFloat(chartData.pieces.count) && touchLocation < CGFloat(index+1)/CGFloat(chartData.pieces.count)
    }
    
    func updateCurrentValue()    {
        guard let chartData = viewModel.chartData else { return }
        let index = Int(touchLocation * CGFloat(chartData.pieces.count))
        guard index < chartData.pieces.count && index >= 0 else {
            currentValue = ""
            currentLabel = ""
            return
        }
        
        currentValue = "\(chartData.pieces[index].value)"
        currentLabel = chartData.pieces[index].label
    }
    
    func labelOffset(in width: CGFloat) -> CGFloat {
        guard let chartData = viewModel.chartData else { return .zero }
        let currentIndex = Int(touchLocation * CGFloat(chartData.pieces.count))
        guard currentIndex < chartData.pieces.count && currentIndex >= 0 else { return 0 }
        let cellWidth = width / CGFloat(chartData.pieces.count)
        let actualWidth = width - cellWidth
        let position = cellWidth * CGFloat(currentIndex) - actualWidth / 2
        return position
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(viewModel: BarChartViewModel())
            .previewLayout(.fixed(width: 343, height: 325))
    }
}
