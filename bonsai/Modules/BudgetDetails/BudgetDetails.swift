//
//  BudgetDetails.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI
import CoreData

struct BudgetDetails: View {
   @EnvironmentObject var budgetService: BudgetService
   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>

   @State var isPresented: Bool = false
   @State private var isOperationPresented = false
   @State private var isEditBudgetPresented = false
   @State private var isCreateBudgetPresented = false

   func allTransactions() -> [NSDecimalNumber] {
      guard let creationDate = budgetService.getBudget()?.createdDate else { return [] }
      return transactions
         .filter { $0.date > creationDate}
         .map { $0.amount }
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
            amount: budgetService.getTotalMoneyLeft(with: allTransactions()),
            titleColor: BonsaiColor.green
         )
         .padding(.leading, 16)
         BudgetMoneyTitleView(
            title: L.Money_spent,
            amount: budgetService.getTotalMoneySpent(with: expenseTransactions()),
            titleColor: BonsaiColor.secondary
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
         ActionScrollView(spaceName: "Budget") { completion in
            isOperationPresented = true
            completion()
         } progress: { state in
            if case .increasing(let offset) = state {
               ZStack {
                  Circle()
                     .foregroundColor(BonsaiColor.mainPurple)
                     .frame(width: offset.rounded() / 1.5, height: offset.rounded() / 1.5, alignment: .center)
                     .offset(y: -offset / 2)

                  BonsaiImage.plus
                     .resizable()
                     .frame(width: offset.rounded() / 3, height: offset.rounded() / 3, alignment: .center)
                     .foregroundColor(.white)
                     .offset(y: -offset / 2)
               }
            }
         } content: {
            VStack(spacing: 0) {
               if UserSettings.showDragDownHint {
                  DragDownHintView().frame(maxWidth: .infinity)
               }
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
                        if let _ = budgetService.getBudget() {
                           isEditBudgetPresented = true
                        } else {
                           isCreateBudgetPresented = true
                        }
                     }
               } // HStack

               budgetMoneyTitleView()
                  .padding(.top, 16)

               budgetMoneyCardView()
                  .padding(.top, 32)
            } // VStack
         } // ActionScrollView
         Spacer()
         tapViewTransactions()
            .frame(height: 148, alignment: .bottom)
            .padding(.bottom, 24)
      }
      .popover(isPresented: $isPresented, content: {
         BudgetTransactions(isPresented: $isPresented)
      })
      .popover(isPresented: $isOperationPresented) {
         OperationDetails(isPresented: $isOperationPresented).onAppear {
            UserSettings.incrementCountOfDragsDown()
         }
      }
      .popover(isPresented: $isEditBudgetPresented, content: {
         CreateEditBudget(
            isCreateEditBudgetPresented: $isEditBudgetPresented,
            kind: .edit
         )
      })
      .popover(isPresented: $isCreateBudgetPresented, content: {
         CreateEditBudget(
            isCreateEditBudgetPresented: $isCreateBudgetPresented,
            kind: .new
         )
      })
   }
}

struct BudgetDetails_Previews: PreviewProvider {
   static var previews: some View {
      BudgetDetails()
         .environmentObject(BudgetService(
            budgetRepository: BudgetRepository(),
            budgetCalculations: BudgetCalculations()
         ))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
