//
//  BudgetFlowView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetFlowView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            Image(Asset.accountBalance.name)
                .resizable()
                .frame(width: 24, height: 24)
            Text("Total budget")
                .font(BonsaiFont.subtitle_15)
                .foregroundColor(BonsaiColor.mainPurple)
                .padding(.top, 10)
            Text("$400")
                .font(BonsaiFont.title_22)
                .foregroundColor(BonsaiColor.text)
                .padding(.top, 8)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
        .background(BonsaiColor.card)
        .cornerRadius(13)
    }
}

struct BudgetFlowView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetFlowView()
            .previewLayout(.fixed(width: 171, height: 116))
    }
}
