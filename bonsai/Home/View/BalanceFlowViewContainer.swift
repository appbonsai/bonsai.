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
        VStack(alignment: .center) {
            HomeControlsView()
            Text("$2,452.00")
                .font(.system(size: 34))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.leading, 16)
            HStack(alignment: .center, spacing: 16) {
                BalanceFlowView()
                BalanceFlowView()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }.background(BonsaiColor.back)
    }
}

struct BalanceFlowViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        BalanceFlowViewContainer()
    }
}
