//
//  HomeControls.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

struct HomeControlsView: View {
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

struct HomeControlsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeControlsView()
    }
}
