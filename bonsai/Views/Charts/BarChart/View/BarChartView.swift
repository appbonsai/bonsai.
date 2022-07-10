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
                Text(viewModel.chartData.leftTitle)
                    .font(BonsaiFont.caption_12)
                    .foregroundColor(BonsaiColor.text)
                    .rotated()
                    .padding(.trailing, 8)
            
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
                        if !currentLabel.isEmpty {
                            BarDetailLabel(title: currentValue, color: viewModel.chartData.piecesColor)
                                .offset(x: labelOffset(in: geo.frame(in: .local).width))
                                .animation(.easeIn)
                            
                        }
                        
                        // bars 
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
                    
                    Text(viewModel.chartData.bottomTitle)
                        .font(BonsaiFont.caption_12)
                        .foregroundColor(BonsaiColor.text)
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
        touchLocation > CGFloat(index)/CGFloat(viewModel.chartData.pieces.count) && touchLocation < CGFloat(index+1)/CGFloat(viewModel.chartData.pieces.count)
    }
    
    func updateCurrentValue()    {
        let index = Int(touchLocation * CGFloat(viewModel.chartData.pieces.count))
        guard index < viewModel.chartData.pieces.count && index >= 0 else {
            currentValue = ""
            currentLabel = ""
            return
        }
        
        currentValue = "\(viewModel.chartData.pieces[index].value)"
        currentLabel = viewModel.chartData.pieces[index].label
    }
    
    func labelOffset(in width: CGFloat) -> CGFloat {
        let currentIndex = Int(touchLocation * CGFloat(viewModel.chartData.pieces.count))
        guard currentIndex < viewModel.chartData.pieces.count && currentIndex >= 0 else { return 0 }
        let cellWidth = width / CGFloat(viewModel.chartData.pieces.count)
        let actualWidth = width - cellWidth
        let position = cellWidth * CGFloat(currentIndex) - actualWidth / 2
        return position
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(viewModel: BarChartViewModel())
            .previewLayout(.fixed(width: 358, height: 325))
    }
}
