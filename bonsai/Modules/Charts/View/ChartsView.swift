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
          Text("Charts")
             .font(BonsaiFont.title_28)
             .foregroundColor(BonsaiColor.text)
             .padding(.top, 8)

          ScrollView(.vertical, showsIndicators: false) {
             VStack(alignment: .leading, spacing: 24) {
                ChartContainer(title: "Balance") {
                   BarChartView(
                     viewModel: BarChartViewModel(
                        chartData: mapToBarChartData()
                     )
                   )
                }
                ChartContainer(title: "Expenses", chartSize: .big) {
                    PieChartView(viewModel: PieChartViewModel(chartData: mapToPieChartData()))
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
