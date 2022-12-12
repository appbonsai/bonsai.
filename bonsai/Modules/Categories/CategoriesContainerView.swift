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
    @State private var isAllSetPresented = false

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
    
    @State var isDeleteConfirmationPresented = false
    @Environment(\.managedObjectContext) private var moc
    
    func removeCategoryButton() -> some View {
        BonsaiImage.trash
            .onTapGesture {
                isDeleteConfirmationPresented = true
            }
            .foregroundColor(BonsaiColor.secondary)
            .opacity(0.8)
            .confirmationDialog(
                selectedCategory == nil ? L.Category.Select.confirmation : L.Delete.Category.confirmation,
                isPresented: $isDeleteConfirmationPresented,
                titleVisibility: .visible
            ) {
                Button(
                    selectedCategory == nil ? "" : L.Category.Delete.confirmation,
                    role: selectedCategory == nil ? .cancel : .destructive
                ) {
                    if let selectedCategory {
                        moc.delete(selectedCategory)
                        do {
                            try moc.save()
                        } catch (let e) {
                            assertionFailure(e.localizedDescription)
                        }
                        self.selectedCategory = nil
                    }
                }
                Button(LocalizedStringKey("Cancel_title"), role: .cancel) {
                    isDeleteConfirmationPresented = false
                }
            }
    }
    
//    func deselectCategory() -> some View {
//        BonsaiImage.unselect
//            .onTapGesture {
//                selectedCategory = nil
//            }
//            .foregroundColor(BonsaiColor.blueLight)
//            .opacity(0.8)
//    }
    
    
    var body: some View {
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
                                if selectedCategory == category {
                                    selectedCategory = nil
                                } else {
                                    selectedCategory = category
                                }
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
                    Button(action: {
                        isPresented = false
                    }) {
                        Text(LocalizedStringKey("Save_title"))
                            .foregroundColor(BonsaiColor.mainPurple)
                    }
                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    if categories.count != 0 {
//                        deselectCategory()
//                    }
//                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if categories.count != 0 {
                        removeCategoryButton()
                    }
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
            Subscriptions(completion: {
                isAllSetPresented = true
            })
        }
        .fullScreenCover(isPresented: $isAllSetPresented) {
            AllSet()
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
