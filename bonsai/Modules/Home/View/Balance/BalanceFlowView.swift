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
            Spacer()
            Text(LocalizeService.Revenue_title)
                .font(.system(size: 15))
                .foregroundColor(BonsaiColor.green)
                .padding(.top, 4)
            Text("$537")
                .font(.system(size: 22))
                .foregroundColor(.white)
                .padding(.top, 8)

            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Image(Asset.arrowGreenUp.name)
                    .resizable()
                    .frame(width: 12, height: 14)
                Text("22% \(LocalizeService.Target_title)")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .padding(.leading, 16)
        .background(BonsaiColor.card)
        .cornerRadius(13)
    }
}

struct BalanceFlowView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceFlowView()
            .previewLayout(.fixed(width: 171, height: 116))
    }
}
