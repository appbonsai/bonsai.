//
//  BudgetNameView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetNameView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(Asset.sunMax.name)
                .resizable()
                .frame(width: 34, height: 34)
            Text("Summer Budget")
                .font(BonsaiFont.title_28)
                .foregroundColor(.white)
                .padding(.leading, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BudgetNameView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetNameView()
            .background(BonsaiColor.card)
    }
}
