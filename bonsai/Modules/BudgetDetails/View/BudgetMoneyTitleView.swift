//
//  BudgetBalanceFlowView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetMoneyTitleView: View {
    
    private let title: String
    private let amount: NSDecimalNumber
    private let titleColor: Color
    
    init(title: String, amount: NSDecimalNumber, titleColor: Color) {
        self.title = title
        self.amount = amount
        self.titleColor = titleColor
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(title))
                .font(BonsaiFont.subtitle_15)
                .foregroundColor(titleColor)
            Text("\(Currency.Validated.current.symbol)\(amount)")
                .font(BonsaiFont.title_34)
                .foregroundColor(BonsaiColor.text)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BudgetTitleView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetMoneyTitleView(title: "MoneyLeft", amount: 375, titleColor: BonsaiColor.secondary)
            .previewLayout(.fixed(width: 171, height: 63))
            .background(BonsaiColor.card)
    }
}
