//
//  BudgetDateSelectorView.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/10/2022.
//

import SwiftUI

struct BudgetDateSelectorView: View {
   
   let selectedPeriod: String

   var body: some View {
      HStack(spacing: 8) {
         BonsaiImage.calendar
            .renderingMode(.template)
            .foregroundColor(BonsaiColor.purple3)
            .padding([.leading, .top, .bottom], 16)
         Text(LocalizedStringKey("Period_title"))
            .foregroundColor(BonsaiColor.purple3)
            .font(BonsaiFont.body_17)
         Spacer()
         Text(LocalizedStringKey(selectedPeriod))
            .foregroundColor(BonsaiColor.purple3)
            .font(BonsaiFont.body_17)
         (BonsaiImage.chevronForward)
            .renderingMode(.template)
            .padding([.trailing], 24)
            .foregroundColor(BonsaiColor.purple3)
      } // HStack
      .background(BonsaiColor.card)
   }
}

struct BudgetDateSelectorView_Previews: PreviewProvider {
   static var previews: some View {
      BudgetDateSelectorView(selectedPeriod: "")
   }
}
