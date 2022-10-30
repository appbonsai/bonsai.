//
//  ChartContainer.swift
//  bonsai
//
//  Created by Максим Алексеев  on 02.08.2022.
//

import SwiftUI

struct ChartContainer<Chart>: View where Chart : View {
    enum ChartSize {
        case standard
        case big
        
        var size: CGFloat {
            switch self {
            case .standard:
                return 325
            case .big:
                return 432
            }
        }
    }
    
    var chartSize: ChartSize
    var title: String
    var chartView: Chart
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(BonsaiFont.title_20)
                        
                chartView
                    .frame(height: chartSize.size)
                    .cornerRadius(13)
            }
        .opacity(0.8)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
    
    init(title: String, chartSize: ChartSize = .standard,  @ViewBuilder chart: () -> Chart) {
        self.chartView = chart()
        self.title = title
        self.chartSize = chartSize
    }

}

struct ChartContainer_Previews: PreviewProvider {
    static var previews: some View {
        ChartContainer(title: "Balance") {
            BarChartView(viewModel: BarChartViewModel())
        }
    }
}
