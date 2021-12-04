//
//  BalanceFlowView.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

struct BalanceFlowView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Revenue")
                .padding()
            Text("$537")
                .padding()
            HStack {
                Text("Revenue")
                    .padding()
                Text("Revenue")
                    .padding()
            }
        }.background(Color.blue)
    }
}

struct BalanceFlowView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceFlowView()
    }
}
