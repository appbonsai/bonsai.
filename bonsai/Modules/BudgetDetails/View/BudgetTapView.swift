//
//  BudgetDragUpView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetTapView: View {

   let title: String
   
   var body: some View {
      VStack {
         BonsaiImage.arrowUpCircle
            .renderingMode(.template)
            .foregroundColor(Color.white)
            .padding(.bottom, 5)
         Text(LocalizedStringKey(title))
            .font(BonsaiFont.body_17)
            .foregroundColor(BonsaiColor.text)
            .multilineTextAlignment(.center)
            .shimmering(duration: 3.0)
      }
   }
}

struct BudgetDragUpView_Previews: PreviewProvider {
   static var previews: some View {
      BudgetTapView(title: L.dragUpHint)
   }
}
