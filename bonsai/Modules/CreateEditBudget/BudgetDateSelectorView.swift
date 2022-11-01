//
//  BudgetDateSelectorView.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/10/2022.
//

import SwiftUI

struct BudgetDateSelectorView: View {
   
   @Binding var selectedPeriod: String
   
   init(selectedPeriod: Binding<String>) {
      self._selectedPeriod = selectedPeriod
   }

   var body: some View {
         HStack(spacing: 8) {
            BonsaiImage.calendar
               .renderingMode(.template)
               .foregroundColor(BonsaiColor.purple3)
               .padding([.leading, .top, .bottom], 16)
            Text("Period")
               .foregroundColor(BonsaiColor.purple3)
               .font(BonsaiFont.body_17)
            Spacer()
            Text(selectedPeriod)
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
       BudgetDateSelectorView(selectedPeriod: .constant(""))
    }
}
