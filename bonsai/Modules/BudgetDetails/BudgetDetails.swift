//
//  BudgetDetails.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI
import CoreData

struct BudgetDetails: View {
   @State var startOffsetY: CGFloat = UIScreen.main.bounds.height
   @State var currentOffsetY: CGFloat = 0
   @State var endingOffsetY: CGFloat = 0
   private let thresholdY: CGFloat = (UIScreen.main.bounds.height * 0.2) / 2
   
   @EnvironmentObject var budgetService: BudgetService
   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>
   @State var isPresented: Bool = false
   
   func allTransactions() -> [NSDecimalNumber] {
      transactions.map { $0.amount }
   }
   
   func expenseTransactions() -> [NSDecimalNumber] {
      transactions
         .filter { $0.type == .expense }
         .map { $0.amount }
   }

   private func budgetMoneyTitleView() -> some View {
      HStack(alignment: .center, spacing: 16) {
         // TODO: localization
         BudgetMoneyTitleView(
            title: L.Money_left,
            amount: budgetService.getTotalMoneyLeft(with: allTransactions())
         )
            .padding(.leading, 16)
         BudgetMoneyTitleView(
            title: L.Money_spent,
            amount: budgetService.getTotalMoneySpent(with: expenseTransactions())
         )
      }
      .frame(height: 63)
   }

   private func budgetMoneyCardView() -> some View {
      HStack(alignment: .center, spacing: 16) {
         // TODO: localization
         BudgetMoneyCardView(
            title: L.Total_budget,
            amount: budgetService.getTotalBudget()
         )
            .shadow(color: .black, radius: 2, x: 0, y: 2)

         BudgetMoneyCardView(
            title: L.Daily_budget,
            amount: budgetService.getMoneyCanSpendDaily(with: allTransactions())
         )
            .shadow(color: .black, radius: 2, x: 0, y: 2)
      }
      .frame(height: 116)
      .padding(.horizontal, 16)
      .padding(.top, -14)
   }


   private func tapViewTransactions() -> some View {
      BudgetTapView()
         .onTapGesture {
            isPresented = true
         }
         .gesture(
            DragGesture()
               .onChanged{ value in
                  withAnimation(.spring()) {
                     currentOffsetY = value.translation.height - BudgetTapView.height
                  }
               }
               .onEnded { _ in
                  lockBudgetTransactionsOffset()
               }
         )
   }

   var body: some View {
      ZStack {
         VStack {
            VStack(alignment: .leading) {
               BudgetNameView(name: budgetService.getBudget()?.name ?? "Budget")
                  .padding([.top, .leading], 8)
            }
            budgetMoneyTitleView()
            
            ZStack {
               VStack {
                  budgetMoneyCardView()
                  
                  Spacer()
                  
                  tapViewTransactions()
               }
            }
            .padding(.top, 16)
         }
         .popover(isPresented: $isPresented, content: {
            BudgetTransactions(isPresented: $isPresented)
         })
         .ignoresSafeArea()

      }
   }
   
   private func lockBudgetTransactionsOffset() {
      withAnimation(.spring()) {
         if currentOffsetY < -thresholdY {
            endingOffsetY = -startOffsetY
         } else if endingOffsetY != 0 && currentOffsetY > thresholdY {
            endingOffsetY = 0
         }
         currentOffsetY = 0
      }
   }
}

struct BudgetDetails_Previews: PreviewProvider {
   static var previews: some View {
      BudgetDetails()
      .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
      .previewDisplayName("iPhone 12")
   }
}
