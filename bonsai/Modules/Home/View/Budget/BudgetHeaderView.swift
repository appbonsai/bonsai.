//
//  BudgetHeaderView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 08.12.2021.
//

import SwiftUI

struct BudgetHeaderView: View {
    var body: some View {
       ZStack {
          BonsaiColor.newPurple
             .opacity(0.8)
          
          HStack {
             Circle() // needs update when charts will be ready
                .foregroundColor(BonsaiColor.text)
                .frame(width: 75, height: 75)
                .padding(.leading, 16)
             
             VStack(alignment: .leading) {
                Text("Money Spent")
                   .font(BonsaiFont.body_17)
                   .fontWeight(.regular)
                   .foregroundColor(BonsaiColor.text)
                
                Text("$14.00")
                   .font(BonsaiFont.title_28)
                   .foregroundColor(.white)
                Text("out of $28")
                   .font(BonsaiFont.body_15)
                   .fontWeight(.regular)
                   .foregroundColor(BonsaiColor.text)
                
             }
             .padding(.vertical, 28)
             .padding(.leading, 16)
             
             Spacer()
          }
          .cornerRadius(13)
       }
    }
}

struct BudgetHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetHeaderView()
    }
}
