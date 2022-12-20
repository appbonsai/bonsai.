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
    
    private var isPremium: Bool {
        if purchaseService.isSubscriptionActive {
            return true
        }
        let limitedBudgets = 3
        var limitedAccountBudgets: [FetchedResults<Budget>.Element] = []
        for account in accounts {
            limitedAccountBudgets = fetchedBudgets.filter { $0.accountId == account.id }
        }
        return limitedAccountBudgets.count < limitedBudgets
    }
    
//    @Binding var selectedTags: OrderedSet<Tag>
//    @Binding var isPresented: Bool
    
    @State var isCreateBudgetPresented: Bool = false
    @State var isDeleteConfirmationPresented = false
    @Environment(\.managedObjectContext) private var moc
    @State var selectedRow: Int = 0

    
    let budgets: [String] = [
       "Budget 1", "Budget 2"
    ]
    
    
    func removeTagButton() -> some View {
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
//                    if !selectedTags.isEmpty {
//                        selectedTags.forEach {
//                            moc.delete($0)
//                            do {
//                                try moc.save()
//                            } catch (let e) {
//                                assertionFailure(e.localizedDescription)
//                            }
//                        }
//                        self.selectedTags = []
//                    }
                    
                }
                Button(LocalizedStringKey("Cancel_title"), role: .cancel) {
                    isDeleteConfirmationPresented = false
                }
            }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(Array(try! moc.fetch(Budget.fetchRequest()).enumerated()), id: \.offset) { index, budget in
                            
                            HStack() {
                                Text(LocalizedStringKey(budget.name))
                                    .foregroundColor(BonsaiColor.text)
                                    .font(BonsaiFont.body_17)
                                Spacer()
                            }
                            .padding([.vertical, .leading], 20)
                            .background(BonsaiColor.card)
                            .cornerRadius(13)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(
                                        BonsaiColor.mainPurple,
                                        lineWidth: selectedRow == index ? 2 : 0
                                    )
                            )
                            .onTapGesture {
                                selectedRow = index
                            }
                        } // ForEach
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
                        Text(LocalizedStringKey("Save_title"))
                            .foregroundColor(BonsaiColor.blueLight)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    if fetchedBudgets.count != 0 {
                        removeTagButton()
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
            CreateEditBudget(kind: .new)
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
}

struct BudgetList_Previews: PreviewProvider {
    static var previews: some View {
        BudgetList()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
    
}
