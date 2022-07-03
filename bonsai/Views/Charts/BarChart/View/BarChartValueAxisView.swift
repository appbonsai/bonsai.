//
//  BarChartValueAxisView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import SwiftUI

struct BarChartValueAxisView: View {
    var mockValues = ["50k", "10k", "5k", "1k", "500"] // temporary until i ll do bussiness logic connected to calculation of that values
    var body: some View {
        VStack(spacing: 53) {
            ForEach(mockValues, id: \.self) { value in
                HStack(spacing: 7) {
                    Text(value)
                        .font(BonsaiFont.caption_12)
                        .foregroundColor(BonsaiColor.text)
                    
                    Rectangle()
                        .frame(height: 1)
                    .foregroundColor(BonsaiColor.disabled)
                }
            }
        }
    }
}

struct BarChartValueAxisView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartValueAxisView()
    }
}
