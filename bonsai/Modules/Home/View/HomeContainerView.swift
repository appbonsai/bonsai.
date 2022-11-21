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
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
    private var transactions: FetchedResults<Transaction>
    
    @FetchRequest(sortDescriptors: [])
    private var budgets: FetchedResults<Budget>
    private var budget: Budget? { budgets.first }
    
    private func tapViewTransactions() -> some View {
        BudgetTapView(title: L.dragUpHint)
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
    
    func income() -> NSDecimalNumber {
        transactions
            .lazy
            .filter { $0.type == .income }
            .filter {
                Calendar.current.component(.month, from: $0.date)
                == Calendar.current.component(.month, from: Date().startOfDay)
            }
            .map { $0.amount }
            .reduce(NSDecimalNumber.zero, { partialResult, dec in
                partialResult.adding(dec)
            })
            .round()
    }
    
    func expense() -> NSDecimalNumber {
        transactions
            .lazy
            .filter { $0.type == .expense }
            .filter {
                Calendar.current.component(.month, from: $0.date)
                == Calendar.current.component(.month, from: Date().startOfDay)
            }
            .map { $0.amount }
            .reduce(NSDecimalNumber.zero, { partialResult, dec in
                partialResult.adding(dec)
            })
            .round()
    }
    
    func totalBalance() -> NSDecimalNumber {
        transactions
            .lazy
            .reduce(into: NSDecimalNumber.zero, { partialResult, dec in
                if dec.type == .expense {
                    partialResult = partialResult.subtracting(dec.amount)
                } else if dec.type == .income {
                    partialResult = partialResult.adding(dec.amount)
                }
            })
            .round()
    }
    
    func allTransactions() -> [NSDecimalNumber] {
        transactions.map { element -> NSDecimalNumber in
            element.amount
        }
    }
    
    func calculateRevenuePercentage() -> Int {
        let dividend = (income().intValue + expense().intValue)
        return dividend != 0 ? (income().intValue * 100 / dividend) : 0
    }
    
    func calculateExpensePercentage() -> Int {
        let dividend = (income().intValue + expense().intValue)
        return dividend != 0 ? (expense().intValue * 100 / dividend) : 0
    }
    
    func filterTransaction(by categories: [Category]) -> [Transaction] {
        guard let budget else { return [] }
        return transactions
            .onlyFromBudget(budget)
            .filter {
                if let category = $0.category {
                    return categories.contains(category)
                } else {
                    return false
                }
            }
    }
    
    fileprivate func buildBudgetView() -> some View {
        let categories = {
            if let budget {
                return BudgetCalculator.mostExpensiveCategories(
                    budget: budget,
                    transactions: transactions
                )
            } else {
                return []
            }
        }()
        return BudgetView(data: categories)
            .cornerRadius(13)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
    
    
    fileprivate func buildCreateBudgetView() -> some View {
        Image(Asset.createBudget.name)
            .resizable()
            .scaledToFit()
            .onTapGesture {
                isCreateEditBudgetPresented = true
            }
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
    
    var body: some View {
        VStack {
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
                VStack(alignment: .leading, spacing: 0) {
                    if UserSettings.showDragDownHint {
                        DragDownHintView().frame(maxWidth: .infinity)
                    }
                    Text(L.netWorth)
                        .font(BonsaiFont.subtitle_15)
                        .foregroundColor(BonsaiColor.text)
                        .padding(.top, 16)
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
                    Text(L.thisMonth)
                        .font(BonsaiFont.subtitle_15)
                        .foregroundColor(BonsaiColor.text)
                        .padding(.top, 28)
                    HStack(alignment: .center, spacing: 12) {
                        BudgetMoneyCardView(
                            title: L.revenueTitle,
                            subtitle: "\(income()) \(Currency.Validated.current.symbol)",
                            titleColor: BonsaiColor.green,
                            icon: nil
                        )
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                        BudgetMoneyCardView(
                            title: L.expensesTitle,
                            subtitle: "\(expense()) \(Currency.Validated.current.symbol)",
                            titleColor: BonsaiColor.secondary,
                            icon: nil
                        )
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                    }
                    .frame(height: 76)
                    .padding(.top, 8)
                    
                    Text(L.budgetTitle)
                        .font(BonsaiFont.subtitle_15)
                        .foregroundColor(BonsaiColor.text)
                        .padding(.top, 28)
                    
                    if budgets.isEmpty {
                        buildCreateBudgetView()
                            .padding(.top, 8)
                    } else {
                        buildBudgetView()
                            .padding(.top, 8)
                    }
                    
                    Spacer()
                } // VStack
                .padding(.horizontal, 16)
            } // ActionScrollView
            tapViewTransactions()
                .frame(height: 60, alignment: .bottom)
                .padding(.bottom, 24)
        }
        
        .popover(isPresented: $isOperationPresented) {
            OperationDetails(isPresented: $isOperationPresented).onAppear {
                UserSettings.incrementCountOfDragsDown()
            }
        }
        .popover(isPresented: $isCurrencySelectionPresented) {
            SelectCurrencyPage(
                currencies: Currency.Validated.all,
                selectedCurrency: .current,
                isPresented: $isCurrencySelectionPresented
            )
        }
        .popover(isPresented: $isCreateEditBudgetPresented, content: {
            CreateEditBudget(
                kind: .new,
                isCreateEditBudgetPresented: $isCreateEditBudgetPresented
            )
        })
        .popover(isPresented: $isSettingPresented, content: {
            SettingsContainerView(isPresented: $isSettingPresented)
        })
        .popover(isPresented: $isTransactionsPresented, content: {
            TransactionsList(kind: .all, isPresented: $isTransactionsPresented)
        })
        .onAppear {
            if Currency.Validated.userPreferenceCurrencyCode == nil {
                isCurrencySelectionPresented = true
            }
        }
    }
}

struct HomeContainerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainerView()
    }
}
