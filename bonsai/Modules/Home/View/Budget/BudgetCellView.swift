//
//  BudgetCellView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct BudgetCellView: View {
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(BonsaiColor.secondary)
                .frame(width: 32, height: 32)
                .padding(.vertical, 8)
            Text("Food")
                .font(BonsaiFont.body_15)
                .foregroundColor(BonsaiColor.text)
                .padding(.leading, 10)
            Spacer()
            
            HStack(alignment: .firstTextBaseline, spacing: 3) {
                Text("$58")
                    .font(BonsaiFont.body_15)
                    .foregroundColor(BonsaiColor.text)
                
                Text("/120")
                    .font(BonsaiFont.caption_11)
                    .foregroundColor(BonsaiColor.purple3)
            }
        }
        .background(BonsaiColor.card)
    }
}

struct BudgetCellView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCellView()
    }
}
    
