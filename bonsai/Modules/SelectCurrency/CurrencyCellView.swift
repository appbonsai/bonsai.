//
//  CurrencyCellView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11/9/22.
//

import SwiftUI

struct CurrencyCellView: View {

   let isSelected: Bool
   let currency: Currency.Validated

   var body: some View {
      HStack() {
         Text("\(currency.localizedName) (\(currency.symbol))")
            .foregroundColor(
               isSelected
               ? BonsaiColor.mainPurple
               : BonsaiColor.text
            )
         Spacer()
      }
      .padding([.vertical, .leading], 20)
      .cornerRadius(13)
      .overlay(
         RoundedRectangle(cornerRadius: 13)
            .stroke(
               BonsaiColor.mainPurple,
               lineWidth: isSelected ? 2 : 0
            )
      )
   }
}

struct CurrencyCellView_Previews: PreviewProvider {
   static var previews: some View {
      CurrencyCellView(isSelected: false, currency: .default)
   }
}
