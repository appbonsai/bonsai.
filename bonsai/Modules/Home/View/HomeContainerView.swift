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
    @EnvironmentObject var appStoreModel: AppstoreModel
    @State private var isSettingPresented = false
    @State private var isBudgetListPresented = false
    @State private var isAccountListPresented = false

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
        BudgetTapView(title: "Drag_up_hint")
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
        return dividend != 0 ? (income().intValue * 100 / dividend) : .zero
    }
    
    func calculateExpensePercentage() -> Int {
        let dividend = (income().intValue + expense().intValue)
        return dividend != 0 ? (expense().intValue * 100 / dividend) : .zero
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
    
    fileprivate func createHomeCoordinator() -> some View {
        HStack {
            Spacer()
            ZStack {
                BonsaiColor.card
                    .blur(radius: 1)
                    .opacity(0.8)
                HStack {
//                    Spacer()
//                    BonsaiImage.creditcard
//                        .symbolRenderingMode(.multicolor)
//                        .foregroundStyle(BonsaiColor.green)
//                        .font(.system(size: 22))
//                        .onTapGesture {
//                            isBudgetListPresented = true
//                        }
//                    Spacer()
//                    BonsaiImage.creditcardRectangle
//                        .symbolRenderingMode(.multicolor)
//                        .foregroundStyle(BonsaiColor.orange)
//                        .font(.system(size: 22))
//                        .onTapGesture {
//                            isAccountListPresented = true
//                        }
//                    Spacer()
                    BonsaiImage.settings
                        .font(.system(size: 22))
                        .symbolRenderingMode(.multicolor)
                        .foregroundStyle(BonsaiColor.newPurple)
                        .onTapGesture {
                            isSettingPresented = true
                        }
//                    Spacer()
                }
            }
            .frame(
                width: 40,
                height: 40,
                alignment: .center
            )
            .cornerRadius(13)
            Spacer()
        }
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
                    UpdateView(
                        appURL: appStoreModel.appURL,
                        showUpdate: appStoreModel.showUpdate
                    )
                    .padding(.bottom, 4)
                    
                    if UserSettings.showDragDownHint {
                        DragDownHintView().frame(maxWidth: .infinity)
                    }
  
                    createHomeCoordinator()
                    
                    Text(LocalizedStringKey("net.worth.stat"))
                        .font(BonsaiFont.subtitle_15)
                        .foregroundColor(BonsaiColor.text)
                        .padding(.top, 12)

                    HStack {
                        Text(verbatim: "\(totalBalance()) \(Currency.Validated.current.symbol)")
                            .font(BonsaiFont.title_34)
                            .foregroundColor(BonsaiColor.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    Text(LocalizedStringKey("This_month"))
                        .font(BonsaiFont.subtitle_15)
                        .foregroundColor(BonsaiColor.text)
                        .padding(.top, 16)
                    HStack(alignment: .center, spacing: 12) {
                        BudgetMoneyCardView(
                            title: "Revenue_title",
                            subtitle: "\(income()) \(Currency.Validated.current.symbol)",
                            titleColor: BonsaiColor.green,
                            icon: nil
                        )
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                        BudgetMoneyCardView(
                            title: "Expenses_title",
                            subtitle: "\(expense()) \(Currency.Validated.current.symbol)",
                            titleColor: BonsaiColor.secondary,
                            icon: nil
                        )
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                    }
                    .frame(height: 76)
                    .padding(.top, 12)
                    
                    Text(LocalizedStringKey("Budget_title"))
                        .font(BonsaiFont.subtitle_15)
                        .foregroundColor(BonsaiColor.text)
                        .padding(.top, 16)
                    
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
                .padding(.bottom, 24)
                .padding([.leading, .trailing], 8)
        }
        
        .fullScreenCover(isPresented: $isOperationPresented) {
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
        .fullScreenCover(isPresented: $isCreateEditBudgetPresented, content: {
            CreateEditBudget(
                kind: .new
            )
        })
        .popover(isPresented: $isSettingPresented, content: {
            SettingsContainerView()
        })
        .fullScreenCover(isPresented: $isBudgetListPresented, content: {
            BudgetList()
        })
        .fullScreenCover(isPresented: $isAccountListPresented, content: {
            AccountList()
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
