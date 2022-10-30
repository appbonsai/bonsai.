//
//  BudgetView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct BudgetView: View {
    var categories: [Category]
    var transactions: [Transaction]
    var body: some View {
        ZStack {
            BonsaiColor.card
                .blur(radius: 1)
                .opacity(0.8)
            VStack(alignment: .leading) {
                BudgetHeaderView()
                    .padding(.horizontal, -16)
                
                Text(L.Home_category)
                    .font(BonsaiFont.subtitle_15)
                    .foregroundColor(BonsaiColor.text)
                    .padding(.top, 16)
                
                VStack(spacing: 0) {
                    ForEach(categories, id: \.id) { category in
    
                        BudgetCellView(title: category.title,
                                       amount: transactions
                                                    .filter { $0.category == category }
                                                    .map { $0.amount.intValue }
                                                    .reduce(0, +))
                        BonsaiColor.separator
                            .frame(height: 1)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}
    struct BudgetView_Previews: PreviewProvider {
        static var previews: some View {
            BudgetView(categories: [], transactions: [])
                .previewLayout(.fixed(width: 358, height:330))
        }
    }
