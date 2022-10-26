//
//  ChartsView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct ChartsView: View {
    var body: some View {
        ZStack {
            BonsaiColor.back
            VStack(alignment: .leading) {
                Text("Charts")
                    .font(BonsaiFont.title_34)
                    .foregroundColor(BonsaiColor.text)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        ChartContainer(title: "Balance") {
                            BarChartView(viewModel: BarChartViewModel())
                        }
                        
                        ChartContainer(title: "Expenses", chartSize: .big) {
                            PieChartView(viewModel: PieChartViewModel())
                        }
                    }
                }
                .padding(.vertical, 20)
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
    }
}

struct ChartsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
            
    }
}
