//
//  BalanceFlowView.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

struct BalanceFlowView: View {
    enum FlowType {
        case revenue
        case expense
    }
    
    var text: NSDecimalNumber
    var flowType: FlowType
    init(text: NSDecimalNumber, flowType: FlowType) {
        self.text = text
        self.flowType = flowType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            Text(flowType == .expense ? L.Expenses_title : L.Revenue_title)
                .font(BonsaiFont.subtitle_15)
                .foregroundColor(flowType == .expense ? BonsaiColor.secondary : BonsaiColor.green)
                .padding(.top, 4)
            Text("\(text)")
                .font(BonsaiFont.title_22)
                .foregroundColor(BonsaiColor.text)
                .padding(.top, 8)
            
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Image(flowType == .expense ? Asset.arrowRedDown.name : Asset.arrowGreenUp.name)
                    .resizable()
                    .frame(width: 12, height: 14)
                Text("22% \(L.Target_title)")
                    .font(BonsaiFont.subtitle_15)
                    .foregroundColor(BonsaiColor.text)
                
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
        BalanceFlowView(text: 234, flowType: .expense)
            .previewLayout(.fixed(width: 171, height: 116))
    }
}
