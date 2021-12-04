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
        VStack(alignment: .leading) {
            Text("Title")
            HStack {
                BalanceFlowView()
                BalanceFlowView()
            }
        }
    }
}

struct BalanceFlowViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        BalanceFlowViewContainer()
    }
}
