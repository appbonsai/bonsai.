//
//  BudgetDetails.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI
import CoreData

struct BudgetDetails: View {
   private let thresholdY: CGFloat = (UIScreen.main.bounds.height * 0.2) / 2
   
   @EnvironmentObject var budgetService: BudgetService
   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>
   @State var isPresented: Bool = false
   @State private var isOperationPresented = false
   @State private var isCreateEditBudgetPresented = false

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
         .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)

         BudgetMoneyCardView(
            title: L.Daily_budget,
            amount: budgetService.getMoneyCanSpendDaily(with: allTransactions())
         )
         .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
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
               .onChanged { value in
                  withAnimation(.spring()) {
                     isPresented = true
                  }
               }
         )
   }

   var body: some View {
      VStack {
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
            }
         } content: {
            VStack() {
                  VStack(spacing: 0) {
                     HStack {
                        BudgetNameView(
                           name: budgetService.getBudget()?.name ?? "Budget"
                        )
                        .padding(.leading, 8)
                        .padding(.top, 16)
                        
                        Spacer()
                        
                        BonsaiImage.pencil
                           .foregroundColor(.white)
                           .font(.system(size: 22))
                           .padding(.trailing, 12)
                           .onTapGesture {
                              isCreateEditBudgetPresented = true
                           }
                     }
                     
                     budgetMoneyTitleView()
                        .padding(.top, 16)
                     
                     budgetMoneyCardView()
                        .padding(.top, 32)
                  }
               
            }
         }
         Spacer()
         tapViewTransactions()
            .frame(height: 148, alignment: .bottom)
            .padding(.bottom, 24)
      }
      .popover(isPresented: $isPresented, content: {
         BudgetTransactions(isPresented: $isPresented)
      })
      .popover(isPresented: $isOperationPresented) {
         OperationDetails(isPresented: $isOperationPresented)
      }
      .popover(isPresented: $isCreateEditBudgetPresented, content: {
         CreateEditBudget(isCreateEditBudgetPresented: $isCreateEditBudgetPresented, kind: .edit)
      })
   }
}

struct BudgetDetails_Previews: PreviewProvider {
   static var previews: some View {
      BudgetDetails()
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
