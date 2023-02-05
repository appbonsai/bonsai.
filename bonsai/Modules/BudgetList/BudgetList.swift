//
//  BudgetList.swift
//  bonsai
//
//  Created by antuan.khoanh on 18/12/2022.
//

import SwiftUI

struct BudgetList: View {
    @EnvironmentObject var purchaseService: PurchaseService
    @State private var isSubscriptionPresented = false
    @State private var isAllSetPresented = false
    @Environment(\.dismiss) var dismiss

    @FetchRequest(sortDescriptors: [])
    private var fetchedBudgets: FetchedResults<Budget>
    @FetchRequest(sortDescriptors: [])
    private var accounts: FetchedResults<Account>
    @State var selectedBudget: Budget?
    
    init() {
        self._selectedBudget = .init(initialValue: fetchedBudgets.first)
    }
    
    private var isPremium: Bool {
        if purchaseService.isSubscriptionActive {
            return true
        }
        let limitedBudgets = 6
        var limitedAccountBudgets: [FetchedResults<Budget>.Element] = []
        for account in accounts {
//            limitedAccountBudgets = fetchedBudgets.filter { $0.accountId == account.id }
        }
        return limitedAccountBudgets.count < limitedBudgets
    }
    
    @State var isCreateBudgetPresented: Bool = false
    @State var isDeleteConfirmationPresented = false
    @Environment(\.managedObjectContext) private var moc
    
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(fetchedBudgets) { budget in
                            HStack() {
                                VStack(alignment: .leading) {
                                    Text(LocalizedStringKey(budget.name))
                                        .foregroundColor(BonsaiColor.text)
                                        .font(BonsaiFont.title_headline_17)
                                    Spacer()
                                    Text("\(budget.amount)")
                                        .foregroundColor(BonsaiColor.text)
                                        .font(BonsaiFont.body_17)
                                }
                                Spacer()
                            }
                            .padding([.vertical, .leading], 20)
                            .background(BonsaiColor.card)
                            .cornerRadius(13)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(
                                        BonsaiColor.mainPurple,
                                        lineWidth: budget == selectedBudget ? 2 : 0
                                    )
                            )
                            .onTapGesture {
                                if selectedBudget == budget {
                                    selectedBudget = nil
                                } else {
                                    selectedBudget = budget
                                }
                            }
                        } // ForEach
                        
                        Button {
                            #warning("Choose and update selected budget")
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .frame(width: 192, height: 48)
                                    .foregroundColor(BonsaiColor.mainPurple)

                                Text(LocalizedStringKey("SelectCurrencyPage.Choose"))
                                    .foregroundColor(BonsaiColor.card)
                                    .font(.system(size: 17))
                                    .bold()
                            }
                        }
                        .opacity(selectedBudget == nil ? 0.5 : 1)
                        .disabled(selectedBudget == nil)
                        
                    } // VStack
                    .padding(2)
                } // ScrollView
                .padding(.top, 24)
                .padding(.horizontal, 16)
            } // ZStack
            .navigationTitle(LocalizedStringKey("budget.default_name"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(LocalizedStringKey("Cancel_title"))
                            .foregroundColor(BonsaiColor.secondary)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    if fetchedBudgets.count != 0 {
                        removeBudgetButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isPremium {
                            isCreateBudgetPresented = true
                        } else {
                            isSubscriptionPresented = true
                        }
                    }) {
                        BonsaiImage.plus
                            .foregroundColor(BonsaiColor.mainPurple)
                    }
                }
            }
        } // NavigationView
        .fullScreenCover(isPresented: $isCreateBudgetPresented) {
            CreateEditBudget(kind: .new) { budget in
                if let budget = budget {
                    self.selectedBudget = budget
                }
            }
        }
        .fullScreenCover(isPresented: $isSubscriptionPresented) {
            Subscriptions(completion: {
                isAllSetPresented = true
            })
        }
        .fullScreenCover(isPresented: $isAllSetPresented) {
            AllSet()
        }
    }
    
    func removeBudgetButton() -> some View {
        BonsaiImage.trash
            .onTapGesture {
                isDeleteConfirmationPresented = true
            }
            .foregroundColor(BonsaiColor.secondary)
            .opacity(0.8)
            .confirmationDialog(
                LocalizedStringKey("delete.tags.confirmation"),
                isPresented: $isDeleteConfirmationPresented,
                titleVisibility: .visible
            ) {
                Button(LocalizedStringKey("tags.delete.confirmation"),
                       role: .destructive) {
                    if let selectedBudget {
                        moc.delete(selectedBudget)
                        do {
                            try moc.save()
                        } catch (let e) {
                            assertionFailure(e.localizedDescription)
                        }
                        self.selectedBudget = nil
                    }
                }
                Button(LocalizedStringKey("Cancel_title"), role: .cancel) {
                    isDeleteConfirmationPresented = false
                }
            }
    }
}

struct BudgetList_Previews: PreviewProvider {
    static var previews: some View {
        BudgetList()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
    
}
