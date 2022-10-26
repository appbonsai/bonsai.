//
//  PieChartView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 29.07.2022.
//

import SwiftUI

struct PieChartView: View {
    @ObservedObject var viewModel: PieChartViewModel
    
    @State var touchLocation = CGPoint(x: -1, y: -1) // x: -1 y: -1 means that user isn't touching the view
    @State var currentSliceData: PieChartSliceData? = nil
    
    var body: some View {
        ZStack {
            BonsaiColor.card
            
            VStack {
                Text(viewModel.chartData.currentMonthName)
                    .foregroundColor(BonsaiColor.disabled)
                    .font(BonsaiFont.title_headline_17)
                    .padding(.bottom, 16)
                    .padding(.top, 16)
                
                if let amount = currentSliceData?.amount.formatted() {
                    Text("$\(amount)")
                        .font(BonsaiFont.title_28)
                        .foregroundColor(BonsaiColor.text)
                } else {
                    Text(" ")
                        .font(BonsaiFont.title_28)
                }
                
                GeometryReader { geo in
                    ForEach(viewModel.chartData.pieChartSlices) { slice in
                        ZStack {
                            PiePieceView(center: CGPoint(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY),
                                         radius: geo.frame(in: .local).width/2,
                                         startDegree: slice.pieSlice?.startDegree ?? 0,
                                         endDegree: slice.pieSlice?.endDegree ?? 0,
                                         isTouched: sliceIsTouched(pieSliceData: slice, inPie: geo.frame(in: .local)),
                                         accentColor: slice.color, disabledColor: slice.disabledColor ?? BonsaiColor.ChartDisabledColors.c1)
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ position in
                                    let pieSize = geo.frame(in: .local)
                                    touchLocation = position.location
                                    updateCurrentValue(pieSize: pieSize)
                                })
                                .onEnded({ _ in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation(Animation.easeInOut) {
                                            resetValues()
                                        }
                                    }
                                })
                        )
                    }
                    
                    ZStack {
                        Circle()
                            .foregroundColor(BonsaiColor.card)
                            .frame(width: geo.frame(in: .local).width/3 * 2, height: geo.frame(in: .local).height/3 * 2) // so circle will occupy a space equal to 2/3 of the whole chart
                            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                        
                        currentSliceData?.icon
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(currentSliceData?.color)
                    }
                }
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 79)
                .padding(.top, 16)
                
                if let currentSliceData = currentSliceData {
                    Text(currentSliceData.categoryTitle)
                        .foregroundColor(currentSliceData.color)
                        .font(BonsaiFont.title_headline_17)
                        .padding(.top, 16)
                } else {
                    Text(" ")
                        .padding(.top, 16)
                }
                
                HStack {
                    if let currentSliceData = currentSliceData {
                        Text("$\(currentSliceData.amount.formatted())")
                            .font(BonsaiFont.title_headline_17)
                            .foregroundColor(BonsaiColor.text)
                        
                        Text(" / \(currentSliceData.percentages.formatted())%")
                            .font(BonsaiFont.body_17)
                            .foregroundColor(BonsaiColor.disabled)
                    } else {
                        Text(" ")
                    }
                }
                .padding(.top, 8)
            }
        }
    }
    
    func updateCurrentValue(pieSize: CGRect)  {
        guard let angle = viewModel.angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation)    else { return }
        let currentIndex = viewModel.chartData.pieChartSlices.firstIndex(where: { $0.pieSlice!.startDegree < angle && $0.pieSlice!.endDegree > angle }) ?? -1
        
        currentSliceData = viewModel.chartData.pieChartSlices[currentIndex]
    }
    
    func resetValues() {
        touchLocation = CGPoint(x: -1, y: -1)
        currentSliceData = nil
    }
    
    func sliceIsTouched(pieSliceData: PieChartSliceData, inPie pieSize: CGRect) -> Bool {
        guard let angle = viewModel.angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation),
              let pieSlice = pieSliceData.pieSlice
        else { return false }
        
        return pieSlice.startDegree < angle && pieSlice.endDegree > angle
     }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(viewModel: PieChartViewModel())
                    .previewLayout(.fixed(width: 358, height: 432))
    }
}
