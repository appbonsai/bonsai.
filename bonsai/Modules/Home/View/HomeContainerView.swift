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
   @EnvironmentObject var budgetService: BudgetService

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

   func totalBalance() -> Int {
      income().intValue - expense().intValue
   }
   
   func allTransactions() -> [NSDecimalNumber] {
      transactions.map { element -> NSDecimalNumber in
         element.amount
      }
   }

   func calculateRevenuePercentage() -> Int {
      income().intValue * 100 / (income().intValue + expense().intValue)
   }

   func calculateExpensePercentage() -> Int {
      expense().intValue * 100 / (income().intValue + expense().intValue)
   }

   func filterTransaction(by categories: [Category]) -> [Transaction] {
      transactions
         .filter {
            if let category = $0.category {
               return categories.contains(category)
            } else {
               return false
            }
         }
   }

   var body: some View {
      ZStack {
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
               Text(verbatim: "\(totalBalance()) $")
                  .font(BonsaiFont.title_34)
                  .foregroundColor(BonsaiColor.text)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundColor(.white)
               HStack(alignment: .center, spacing: 16) {
                  BalanceFlowView(text: income(), flowType: .revenue, percentage: calculateRevenuePercentage())
                     .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                  BalanceFlowView(text: expense(), flowType: .expense, percentage: calculateExpensePercentage())
                     .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
               }
               .frame(height: 116)
               .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)

               Text("Budget")
                  .font(BonsaiFont.title_20)
                  .foregroundColor(.white)
                  .padding(.top, 32)
               
               BudgetView(
                  categories: budgetService.getMostExpensiveCategories(
                     transactions: transactions
                  ),
                  transactions: filterTransaction(
                     by: budgetService.getMostExpensiveCategories(
                        transactions: transactions
                     )
                  )
               )
               .frame(height: 320)
               .cornerRadius(13)
               .onTapGesture {
                  isCreateEditBudgetPresented = true
               }
               .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
               
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
         .environmentObject(BudgetService(
            budgetRepository: BudgetRepository(),
            budgetCalculations: BudgetCalculations()
         ))
   }
}
