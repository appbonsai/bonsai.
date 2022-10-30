//
//  BudgetCellView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct BudgetCellView: View {
    var title: String
    var amount: Int
    
    var body: some View {
       ZStack {
          BonsaiColor.card
             .blur(radius: 1)
             .opacity(0)
          
          HStack {
             Circle()
                .foregroundColor(BonsaiColor.secondary)
                .frame(width: 32, height: 32)
                .padding(.vertical, 8)
             Text(title)
                .font(BonsaiFont.body_15)
                .foregroundColor(BonsaiColor.text)
                .padding(.leading, 10)
             Spacer()
             
             HStack(alignment: .firstTextBaseline, spacing: 3) {
                Text(verbatim: "$\(amount)")
                   .font(BonsaiFont.body_15)
                   .foregroundColor(BonsaiColor.text)
                
//                Text("/120")
//                   .font(BonsaiFont.caption_11)
//                   .foregroundColor(BonsaiColor.purple3)
             }
          }
       }
    }
}

struct BudgetCellView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCellView(title: "Food", amount: 28)
    }
}
    
