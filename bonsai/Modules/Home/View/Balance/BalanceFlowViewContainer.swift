//
//  BalanceFlowViewContainer.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI


struct BalanceFlowViewContainer: View {
    var body: some View {
        ZStack {
            BonsaiColor.back
            VStack(alignment: .center) {
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
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 38)
        }
        .ignoresSafeArea()
    }
}

struct BalanceFlowViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        BalanceFlowViewContainer()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
