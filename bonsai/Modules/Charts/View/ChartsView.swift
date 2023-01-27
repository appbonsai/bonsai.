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
            Text(LocalizedStringKey("Charts_title"))
                .font(BonsaiFont.title_28)
                .foregroundColor(BonsaiColor.text)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    ChartContainer(title: "charts.balance.title") {
                        let chartData = mapToBarChartData()
                        if !chartData.pieces.isEmpty {
                            BarChartView(
                                viewModel: BarChartViewModel(
                                    chartData: chartData
                                )
                            )
                        } else {
                            EmptyChart(description: "charts.balance.empty")
                        }
                    }
                    ChartContainer(title: "charts.expenses.title", chartSize: .big) {
                        let chartData = mapToPieChartData()
                        if !chartData.pieChartSlices.isEmpty {
                            PieChartView(
                                viewModel: PieChartViewModel(
                                    chartData: chartData
                                )
                            )
                        } else {
                            EmptyChart(description: "charts.balance.empty")
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
