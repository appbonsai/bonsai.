//
//  BudgetBalanceFlowView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetMoneyTitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("$372")
                .font(BonsaiFont.title_34)
                .foregroundColor(BonsaiColor.text)
            Text("MoneyLeft")
                .font(BonsaiFont.subtitle_15)
                .foregroundColor(BonsaiColor.green)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BudgetTitleView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetMoneyTitleView()
            .previewLayout(.fixed(width: 171, height: 63)) //18 + 41 + 4
            .background(BonsaiColor.card)
    }
}
