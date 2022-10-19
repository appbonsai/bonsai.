//
//  BudgetView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct BudgetView: View {
    var body: some View {
        VStack(alignment: .leading) {
            BudgetHeaderView()
                .padding(.horizontal, -16)
            
            Text("The most expensive categories")
                .font(BonsaiFont.subtitle_15)
                .foregroundColor(BonsaiColor.text)
                .padding(.top, 16)
            
            VStack(spacing: 0) {
                ForEach(0..<5) { index in
                    if index.isMultiple(of: 2) {
                        BudgetCellView()
                    } else {
                        BonsaiColor.separator
                            .frame(height: 1)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(BonsaiColor.card)
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
            .previewLayout(.fixed(width: 358, height:330))
    }
}
