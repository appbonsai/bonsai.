//
//  CategoriesContainerView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 10.12.2021.
//

import SwiftUI

struct CategoriesContainerView: View {

    @EnvironmentObject var purchaseService: PurchaseService
    @State private var isSubscriptionPresented = false

    private var isPremium: Bool {
        if purchaseService.isSubscriptionActive {
            return true
        }
        let limitedCategories = 3
        return categories.count < limitedCategories
    }

    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)])
    var categories: FetchedResults<Category>

    @Binding var selectedCategory: Category?
    @Binding var isPresented: Bool
    @State var isCreateCategoryPresented: Bool = false

    var body: some View {
        LoadingAllSet(isShowing: $purchaseService.isShownAllSet) {
            NavigationView {
                ZStack {
                    BonsaiColor.back
                        .ignoresSafeArea()
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(categories) { category in
                                CategoriesCellView(
                                    isSelected: category == selectedCategory,
                                    category: category
                                )
                                .onTapGesture {
                                    selectedCategory = category
                                }
                            } // ForEach
                        } // VStack
                        .padding(2)
                    } // ScrollView
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                } // ZStack
                .navigationTitle(L.Category.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationBackButton(isPresented: $isPresented)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if isPremium {
                                isCreateCategoryPresented = true
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
            .fullScreenCover(isPresented: $isCreateCategoryPresented) {
                CreateCategoryView(isPresented: $isCreateCategoryPresented) { category in
                    if let category = category {
                        self.selectedCategory = category
                        self.isPresented = false
                    }
                }
            }
            .fullScreenCover(isPresented: $isSubscriptionPresented) {
                Subscriptions(isPresented: $isSubscriptionPresented)
            }
        }
    }
}

struct CategoriesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesContainerView(
            selectedCategory: .constant(nil),
            isPresented: .constant(true)
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        .previewDisplayName("iPhone 12")
    }
}
