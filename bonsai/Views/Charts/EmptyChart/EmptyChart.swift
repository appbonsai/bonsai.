//
//  EmptyChart.swift
//  bonsai
//
//  Created by Максим Алексеев  on 02.11.2022.
//

import SwiftUI

struct EmptyChart: View {
    let description: String
    var body: some View {
        ZStack {
            BonsaiColor.card
            
            Text(LocalizedStringKey(description))
                .font(BonsaiFont.title_20)
                .multilineTextAlignment(.center)

        }
    }
}

struct EmptyChart_Previews: PreviewProvider {
    static var previews: some View {
        EmptyChart(description: "This chart will show you how your balance changes over time")
            .previewLayout(.fixed(width: 358, height: 325))
    }
}
