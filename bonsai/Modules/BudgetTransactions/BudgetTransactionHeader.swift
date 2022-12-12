//
//  BudgetTransactionHeader.swift
//  bonsai
//
//  Created by antuan.khoanh on 19/06/2022.
//

import SwiftUI

struct BudgetTransactionHeader: View {
    var body: some View {
       VStack(alignment: .leading) {
          HStack {
             Spacer()
             RoundedCorner()
                .foregroundColor(BonsaiColor.disabled)
                .frame(width: 60, height: 5, alignment: .center)
                .cornerRadius(25, corners: .allCorners)
             Spacer()
          }
          .padding(.top, 20)

          Text("Transactions_title")
             .font(BonsaiFont.title_headline_17)
             .foregroundColor(Color.white)
             .padding(.leading, 16)
             .frame(height: 17)
             .padding(.top, 7)
       }
    }
}

struct BudgetTransactionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BudgetTransactionHeader()
    }
}
