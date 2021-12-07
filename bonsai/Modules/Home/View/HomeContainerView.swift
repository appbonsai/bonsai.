//
//  HomeContainerView.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI


struct HomeContainerView: View {
    var body: some View {
        ZStack {
            BonsaiColor.back
            VStack(alignment: .leading) {
                HomeControlsView()
                Text("$2,452.00")
                    .font(.system(size: 34))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                HStack(alignment: .center, spacing: 16) {
                    BalanceFlowView()
                    BalanceFlowView()
                }
                .frame(height: 116)
                
                Text("Budget")
                    .font(BonsaiFont.title_20)
                    .foregroundColor(.white)
                    .padding(.top, 32)
                
                BudgetView()
                    .frame(height: 320)
                    .cornerRadius(13)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 38)
        }
        .ignoresSafeArea()
    }
}

struct HomeContainerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainerView()
    }
}
