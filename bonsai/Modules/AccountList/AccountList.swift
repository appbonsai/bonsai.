//
//  SwiftUIView.swift
//  bonsai
//
//  Created by antuan.khoanh on 28/01/2023.
//

import SwiftUI

struct AccountList: View {
    @EnvironmentObject var purchaseService: PurchaseService
    @State private var isSubscriptionPresented = false
    @State private var isAllSetPresented = false
    @Environment(\.dismiss) var dismiss

    @FetchRequest(sortDescriptors: [])
    private var fetchedAccounts: FetchedResults<Account>
    @State var selectedAccount: Account?
    
    init() {
        self._selectedAccount = .init(initialValue: fetchedAccounts.first)
    }
    
    private var isPremium: Bool {
        if purchaseService.isSubscriptionActive {
            return true
        }
        let limitedAccounts = 6
        return fetchedAccounts.count < limitedAccounts
    }
    
    @State var isCreateAccountPresented: Bool = false
    @State var isDeleteConfirmationPresented = false
    @Environment(\.managedObjectContext) private var moc
    
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(fetchedAccounts) { account in
                            HStack() {
                                VStack(alignment: .leading) {
                                    Text(LocalizedStringKey(account.title))
                                        .foregroundColor(BonsaiColor.text)
                                        .font(BonsaiFont.title_headline_17)
                                    Spacer()
                                    Text("\(account.id)")
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
                                        lineWidth: account == selectedAccount ? 2 : 0
                                    )
                            )
                            .onTapGesture {
                                if selectedAccount == account {
                                    selectedAccount = nil
                                } else {
                                    selectedAccount = account
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
                        .opacity(selectedAccount == nil ? 0.5 : 1)
                        .disabled(selectedAccount == nil)
                        
                    } // VStack
                    .padding(2)
                } // ScrollView
                .padding(.top, 24)
                .padding(.horizontal, 16)
            } // ZStack
            .navigationTitle(LocalizedStringKey("account.default_name"))
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
                    if fetchedAccounts.count != 0 {
                        removeAccountButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isPremium {
                            isCreateAccountPresented = true
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
        .fullScreenCover(isPresented: $isCreateAccountPresented) {
            CreateEditAccount(kind: .new) { budget in
//                if let budget = budget {
//                    self.selectedBudget = budget
//                }
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
    
    func removeAccountButton() -> some View {
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
                    if let selectedAccount {
                        moc.delete(selectedAccount)
                        do {
                            try moc.save()
                        } catch (let e) {
                            assertionFailure(e.localizedDescription)
                        }
                        self.selectedAccount = nil
                    }
                }
                Button(LocalizedStringKey("Cancel_title"), role: .cancel) {
                    isDeleteConfirmationPresented = false
                }
            }
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        BudgetList()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
    
}

