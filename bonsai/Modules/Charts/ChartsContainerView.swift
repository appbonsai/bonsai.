//
//  ChartsContainerView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct ChartsContainerView: View {
    var body: some View {
        ZStack {
            BonsaiColor.back
            VStack(alignment: .leading) {
                Text("Charts")
                    .font(BonsaiFont.title_34)
                    .foregroundColor(BonsaiColor.text)
                
                VStack(alignment: .leading) {
                    Text("Balance")
                        .foregroundColor(BonsaiColor.text)
                        .font(BonsaiFont.title_20)
                    
                    BarChartView(viewModel: BarChartViewModel())
                        .frame(height: 325)
                        .cornerRadius(13)
                }
                .padding(.top, 24)
                
                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
    }
}

struct ChartsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsContainerView()
    }
}
