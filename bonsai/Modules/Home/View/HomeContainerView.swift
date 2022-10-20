//
//  HomeContainerView.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI
import CoreData

struct HomeContainerView: View {
   @State private var isCreateEditBudgetPresented = false
   @State private var isOperationPresented = false
   @State var showAllSet: Bool = false
   @State private var isCurrencySelectionPresented = false
   @EnvironmentObject var budgetModel: BudgetModel
   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>
   
   func income() -> NSDecimalNumber {
      transactions.reduce(into: [Transaction]()) { partialResult, transaction in
         partialResult.append(transaction)
      }
      .filter { $0.type == .income }
      .map { $0.amount }
      .reduce(0, { partialResult, dec in
         partialResult.adding(dec)
      })
   }
   
   func expense() -> NSDecimalNumber {
      transactions.reduce(into: [Transaction]()) { partialResult, transaction in
         partialResult.append(transaction)
      }
      .filter { $0.type == .expense }
      .map { $0.amount }
      .reduce(0, { partialResult, dec in
         partialResult.adding(dec)
      })
   }
   
   var body: some View {
      ZStack {
         BonsaiColor.back
         ActionScrollView { completion in
            isOperationPresented = true
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
               Text("\(budgetModel.totalMoneyLeft)")
                  .font(.system(size: 34))
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundColor(.white)
               HStack(alignment: .center, spacing: 16) {
                  BalanceFlowView(text: income())
                  BalanceFlowView(text: expense())
               }
               .frame(height: 116)
               
               Text("Budget")
                  .font(BonsaiFont.title_20)
                  .foregroundColor(.white)
                  .padding(.top, 32)
               
               BudgetView()
                  .frame(height: 320)
                  .cornerRadius(13)
                  .onTapGesture {
                     isCreateEditBudgetPresented = true
                  }
               
               Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 38)
         }
      }
      .ignoresSafeArea()
      .popover(isPresented: $isOperationPresented) {
         OperationDetails(isPresented: $isOperationPresented)
      }
      .popover(isPresented: $isCurrencySelectionPresented) {
         SelectCurrencyPage(
            isPresented: $isCurrencySelectionPresented,
            currencies: Currency.Validated.all,
            selectedCurrency: .current
         )
      }
      .popover(isPresented: $isCreateEditBudgetPresented, content: {
         CreateEditBudget(isCreateEditBudgetPresented: $isCreateEditBudgetPresented)
      })
      .onAppear {

                  
         //              if Currency.userPreferenceCurrencyCode == nil {
         //                 isCurrencySelectionPresented = true
         //              }
      }
   }
   
}

struct HomeContainerView_Previews: PreviewProvider {
   static var previews: some View {
      HomeContainerView()
   }
}
