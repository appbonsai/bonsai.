//
//  ChartsView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct ChartsView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: ChartViewModel
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            Text(L.charts)
                .font(BonsaiFont.title_28)
                .foregroundColor(BonsaiColor.text)
                .padding(.top, 8)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    ChartContainer(title: "Balance") {
                        let chartData = mapToBarChartData()
                        if !chartData.pieces.isEmpty {
                            BarChartView(
                                viewModel: BarChartViewModel(
                                    chartData: chartData
                                )
                            )
                        } else {
                            EmptyChart(description: "This chart will show you how your balance changes over time")
                        }
                    }
                    ChartContainer(title: "Expenses", chartSize: .big) {
                        let chartData = mapToPieChartData()
                        if !chartData.pieChartSlices.isEmpty {
                            PieChartView(
                                viewModel: PieChartViewModel(
                                    chartData: chartData
                                )
                            )
                        } else {
                            EmptyChart(description: "This chart will show all categories that you spent money on")
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea()
    }
}

struct ChartsContainerView_Previews: PreviewProvider {
   static var previews: some View {
      ChartsView()
   }
}
