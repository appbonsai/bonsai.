//
//  BudgetFlowView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetMoneyCardView: View {

   let title: String
   let amount: NSDecimalNumber
   let titleColor: Color
   let icon: Image

   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         icon
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(BonsaiColor.purple4)
            .opacity(0.8)
            .padding(.top, 16)
         Text(title)
            .font(BonsaiFont.subtitle_15)
            .foregroundColor(titleColor)
            .padding(.top, 8)
         Text("\(Currency.Validated.current.symbol)\(amount)")
            .font(BonsaiFont.title_22)
            .foregroundColor(BonsaiColor.text)
            .padding(.top, 8)
         Spacer()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.leading, 16)
      .background(BonsaiColor.card.opacity(0.7))
      .cornerRadius(13)
   }
}

struct BudgetFlowView_Previews: PreviewProvider {
   static var previews: some View {
      BudgetMoneyCardView(title: "", amount: 10, titleColor: .red, icon: BonsaiImage.title)
         .previewLayout(.fixed(width: 171, height: 116))
   }
}
