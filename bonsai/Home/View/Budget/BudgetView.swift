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
            .background(BonsaiColor.newPurple)
            .cornerRadius(13)
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
