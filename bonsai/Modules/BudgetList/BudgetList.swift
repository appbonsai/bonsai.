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
    
    @FetchRequest(sortDescriptors: [])
    var tags: FetchedResults<Tag>
//    @Binding var selectedTags: OrderedSet<Tag>
//    @Binding var isPresented: Bool
    
    @State var isCreateTagPresented: Bool = false
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
                        ForEach(Array(budgets.enumerated()), id: \.offset) { index, budget in
                            
                            HStack() {
                                Text(LocalizedStringKey(budget))
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
                            
//                            TagCellView(
//                                isSelected: selectedTags.contains(tag),
//                                tag: tag
//                            )
//                            .onTapGesture {
//                                if selectedTags.append(tag).inserted == false {
//                                    selectedTags.remove(tag)
//                                }
//                            }
                        } // ForEach
                    } // VStack
                    .padding(2)
                } // ScrollView
                .padding(.top, 24)
                .padding(.horizontal, 16)
            } // ZStack
            .navigationTitle(LocalizedStringKey("tags.title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
//                        isPresented = false
                    }) {
                        Text(LocalizedStringKey("Save_title"))
                            .foregroundColor(BonsaiColor.blueLight)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    if tags.count != 0 {
                        removeTagButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isPremium {
                            isCreateTagPresented = true
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
        .fullScreenCover(isPresented: $isCreateTagPresented) {
            CreateTagView(isPresented: $isCreateTagPresented) { tag in
                if let tag = tag, tag.title.isEmpty == false {
//                    self.selectedTags.append(tag)
//                    self.isPresented = false
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
}

struct BudgetList_Previews: PreviewProvider {
    static var previews: some View {
        BudgetList()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
    
}
