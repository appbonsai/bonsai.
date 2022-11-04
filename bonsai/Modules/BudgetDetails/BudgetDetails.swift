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

   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
   private var transactions: FetchedResults<Transaction>

   @FetchRequest(sortDescriptors: [])
   private var budgets: FetchedResults<Budget>
   private var budget: Budget? { budgets.first }

   private var allTransactions: [NSDecimalNumber] {
      guard let budget else { return [] }
      return budgetService
         .filterTransactions(all: transactions, budget: budget)
         .map { $0.amount }
   }
   private var totalMoneyLeft: NSDecimalNumber {
      guard let budget else { return .zero }
      return budgetService.getTotalMoneyLeft(
         with: allTransactions,
         budget: budget
      )
   }
   private var totalMoneySpent: NSDecimalNumber {
      budgetService.getTotalMoneySpent(with: allTransactions)
   }
   private var moneyCanSpendDaily: NSDecimalNumber {
      guard let budget else { return .zero }
      return budgetService.getMoneyCanSpendDaily(
         with: allTransactions,
         budget: budget
      )
   }

   @State var isPresented: Bool = false
   @State private var isOperationPresented = false
   @State private var isEditBudgetPresented = false
   @State private var isCreateBudgetPresented = false

   private func budgetMoneyTitleView() -> some View {
      HStack(alignment: .center, spacing: 24) {
         BudgetMoneyTitleView(
            title: L.Money_left,
            amount: totalMoneyLeft,
            titleColor: BonsaiColor.green
         )
         .padding(.leading, 24)
         BudgetMoneyTitleView(
            title: L.Money_spent,
            amount: totalMoneySpent,
            titleColor: BonsaiColor.secondary
         )
      }
      .frame(height: 63)
   }

   private func budgetMoneyCardView() -> some View {
      HStack(alignment: .center, spacing: 16) {
         BudgetMoneyCardView(
            title: L.Total_budget,
            amount: budget?.amount ?? .zero,
            titleColor: BonsaiColor.mainPurple,
            icon: Image(Asset.accountBalance.name)
         )
         .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)

         BudgetMoneyCardView(
            title: L.Daily_budget,
            amount: moneyCanSpendDaily,
            titleColor: BonsaiColor.mainPurple,
            icon: Image(systemName: "arrow.clockwise")
         )
         .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
      }
      .frame(height: 116)
      .padding(.horizontal, 16)
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

   private var createBudgetSuggestion: some View {
      VStack {
         if UserSettings.showDragDownHint {
            DragDownHintView().frame(maxWidth: .infinity)
         }
         Spacer(minLength: 80)
         VStack(alignment: .center, spacing: 12) {
            Group {
               Text("You don't own a budget yet")
                  .foregroundColor(.white)
                  .font(BonsaiFont.title_20)
               GifImage("bonsai4_png")
                  .frame(width: 200, height: 200)
               Text(
                    """
                    Budget unlocks your beautiful bonsai tree
                    """
               )
               .multilineTextAlignment(.center)
               .foregroundColor(.white)
               .font(BonsaiFont.body_17)
               Button {
                  isCreateBudgetPresented = true
               } label: {
                  Text("Start budgeting now!")
               }
               .buttonStyle(PrimaryButtonStyle())
            }.padding(16)
         }
         .background(BonsaiColor.card)
         .cornerRadius(13)
      }
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
            if budget == nil {
               createBudgetSuggestion
            } else {
               VStack(spacing: 0) {
                  if UserSettings.showDragDownHint {
                     DragDownHintView().frame(maxWidth: .infinity)
                  }
                  HStack {
                     BudgetNameView(name: budget?.name ?? "Budget")
                        .padding(.leading, 8)
                        .padding(.top, 16)

                     Spacer()

                     BonsaiImage.pencil
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                        .padding(.trailing, 12)
                        .onTapGesture {
                           if budget != nil {
                              isEditBudgetPresented = true
                           }
                        }
                  } // HStack

                  budgetMoneyTitleView()
                     .padding(.top, 32)

                  budgetMoneyCardView()
                     .padding(.top, 32)
               } // VStack
            }
         } // ActionScrollView
         if budget != nil {
            Spacer()
            tapViewTransactions()
               .frame(height: 148, alignment: .bottom)
               .padding(.bottom, 24)
         }
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
            kind: .edit,
            isCreateEditBudgetPresented: $isEditBudgetPresented
         )
      })
      .popover(isPresented: $isCreateBudgetPresented, content: {
         CreateEditBudget(
            kind: .new,
            isCreateEditBudgetPresented: $isCreateBudgetPresented
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
