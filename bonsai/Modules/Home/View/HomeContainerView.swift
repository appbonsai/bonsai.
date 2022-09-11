//
//  HomeContainerView.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

struct HomeContainerView: View {

   @State private var isNewOperationPresented = false

   var body: some View {
      ZStack {
         BonsaiColor.back
         ActionScrollView { completion in
            isNewOperationPresented = true
            completion()
         } progress: { state in
            if case .increasing(let offset) = state {
               ZStack {
                  Circle()
                     .foregroundColor(BonsaiColor.mainPurple)
                     .frame(width: offset.rounded() / 1.5, height: offset.rounded() / 1.5, alignment: .center)
                  BonsaiImage.plus
                     .resizable()
                     .frame(width: offset.rounded() / 3, height: offset.rounded() / 3, alignment: .center)
                     .foregroundColor(.white)
               }
            } else {
               BonsaiImage.plus
                  .resizable()
                  .frame(width: 20, height: 20, alignment: .center)
            }
         } content: {
            VStack(alignment: .leading) {
               Text("$2,452.00")
                  .font(.system(size: 34))
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundColor(.white)
               HStack(alignment: .center, spacing: 16) {
                  BalanceFlowView()
                  BalanceFlowView()
               }
               .frame(height: 116)

               Text("Budget")
                  .font(BonsaiFont.title_20)
                  .foregroundColor(.white)
                  .padding(.top, 32)

               BudgetView()
                  .frame(height: 320)
                  .cornerRadius(13)

               Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 38)
         }
      }
      .ignoresSafeArea()
      .popover(isPresented: $isNewOperationPresented) {
          SelectCurrencyPage(isPresented: $isNewOperationPresented, currencies: Currency.allAvailableCurrencies, selectedCurrency: .current)
//         NewOperationView(isPresented: $isNewOperationPresented)
      }
   }
}

struct HomeContainerView_Previews: PreviewProvider {
   static var previews: some View {
      HomeContainerView()
   }
}
