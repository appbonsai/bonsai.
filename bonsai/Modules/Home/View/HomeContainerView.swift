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
    @State private var isSettingPresented = false
    @State private var isCreateEditBudgetPresented = false
    @State private var isOperationPresented = false
    @State var showAllSet: Bool = false
    @State private var isCurrencySelectionPresented = false
    @State var isTransactionsPresented: Bool = false
    
    @EnvironmentObject var budgetService: BudgetService
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Transaction>
    
    
    fileprivate func BudgeView() -> some View {
        let ftransactions = filterTransaction(
            by: budgetService.getMostExpensiveCategories(
                transactions: transactions
            )
        )
        return BudgetView(
            categories: budgetService.getMostExpensiveCategories(
                transactions: transactions
            ),
            transactions: ftransactions
        )
        .frame(height: 320)
        .cornerRadius(13)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
    
    
    fileprivate func createBudgetView() -> some View {
        Image("create_budget")
            .resizable()
            .scaledToFit()
            .onTapGesture {
                isCreateEditBudgetPresented = true
            }
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
    
    private func tapViewTransactions() -> some View {
        BudgetTapView()
            .onTapGesture {
                isTransactionsPresented = true
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            isTransactionsPresented = true
                        }
                    }
            )
    }
    
    
    var body: some View {
//        GeometryReader { geo in
            
            ActionScrollView(spaceName: "Home") { completion in
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
                VStack(alignment: .leading) {
                    if UserSettings.showDragDownHint {
                        DragDownHintView().frame(maxWidth: .infinity)
                    } else {
                        Spacer(minLength: 38)
                    }
                    HStack {
                        Text(verbatim: "\(totalBalance()) \(Currency.Validated.current.symbol)")
                            .font(BonsaiFont.title_34)
                            .foregroundColor(BonsaiColor.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        BonsaiImage.settings
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .onTapGesture {
                                isSettingPresented = true
                            }
                    }
                    HStack(alignment: .center, spacing: 16) {
                        BalanceFlowView(text: income(), flowType: .revenue, percentage: calculateRevenuePercentage())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                        BalanceFlowView(text: expense(), flowType: .expense, percentage: calculateExpensePercentage())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .frame(height: 116)
                    
                    Text("Budget")
                        .font(BonsaiFont.title_20)
                        .foregroundColor(.white)
                        .padding(.top, 32)
                    
                    if let _ = budgetService.getBudget() {
                        BudgeView()
                    } else {
                        createBudgetView()
                    }
                    
                    Spacer()
                    HStack(alignment: .center) {
                        Spacer()
                        tapViewTransactions()
                            .frame(height: 148, alignment: .bottom)
                                                    .padding(.bottom, 24)
                        Spacer()
                    }
                } // VStack
                .padding(.horizontal, 16)
//                .frame(minHeight: geo.size.height)
            } // ActionScrollView
//            .frame(width: geo.size.width, height: geo.size.height)
//        } // GeometryReader
        .popover(isPresented: $isOperationPresented) {
            OperationDetails(isPresented: $isOperationPresented).onAppear {
                UserSettings.incrementCountOfDragsDown()
            }
        }
        .popover(isPresented: $isCurrencySelectionPresented) {
            SelectCurrencyPage(
                isPresented: $isCurrencySelectionPresented,
                currencies: Currency.Validated.all,
                selectedCurrency: .current
            )
        }
        .popover(isPresented: $isCreateEditBudgetPresented, content: {
            CreateEditBudget(isCreateEditBudgetPresented: $isCreateEditBudgetPresented, kind: .new)
        })
        .popover(isPresented: $isSettingPresented, content: {
            SettingsContainerView(isPresented: $isSettingPresented)
        })
        .popover(isPresented: $isTransactionsPresented, content: {
           BudgetTransactions(isPresented: $isTransactionsPresented)
        })
        .onAppear {
            if Currency.Validated.userPreferenceCurrencyCode == nil {
                //                isCurrencySelectionPresented = true
            }
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
