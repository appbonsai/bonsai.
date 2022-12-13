//
//  LegendCellView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import SwiftUI

struct LegendCellView: View {
    let legend: ChartLegend
    
    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .frame(width: 8, height: 8)
                .cornerRadius(16)
                .foregroundColor(legend.color)
            
            Text(LocalizedStringKey(legend.title))
                .font(BonsaiFont.caption_12)
                .foregroundColor(BonsaiColor.text)
        }
    }
}

struct LegendCellView_Previews: PreviewProvider {
    static var previews: some View {
        LegendCellView(legend: .init(color: BonsaiColor.mainPurple, title: "Balance"))
    }
}
