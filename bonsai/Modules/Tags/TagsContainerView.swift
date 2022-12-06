//
//  TagsContainerView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.06.2022.
//

import SwiftUI
import OrderedCollections

struct TagsContainerView: View {
    
    @EnvironmentObject var purchaseService: PurchaseService
    @State private var isSubscriptionPresented = false
    
    private var isPremium: Bool {
        if purchaseService.isSubscriptionActive {
            return true
        }
        let limitedTags = 3
        return tags.count < limitedTags
    }
    
    @FetchRequest(sortDescriptors: [])
    var tags: FetchedResults<Tag>
    @Binding var selectedTags: OrderedSet<Tag>
    @Binding var isPresented: Bool
    @State var isCreateTagPresented: Bool = false
    
    @State var isDeleteConfirmationPresented = false
    @Environment(\.managedObjectContext) private var moc
    
    func removeTagButton() -> some View {
        BonsaiImage.trash
            .onTapGesture {
                isDeleteConfirmationPresented = true
            }
            .foregroundColor(BonsaiColor.secondary)
            .opacity(0.8)
            .confirmationDialog(
                selectedTags == [] ? L.Tags.Select.confirmation : L.Delete.Tags.confirmation,
                isPresented: $isDeleteConfirmationPresented,
                titleVisibility: .visible
            ) {
                Button(selectedTags == [] ? "" : L.Tags.Delete.confirmation,
                       role: selectedTags == [] ? .cancel : .destructive) {
                    if !selectedTags.isEmpty {
                        selectedTags.forEach {
                            moc.delete($0)
                            do {
                                try moc.save()
                            } catch (let e) {
                                assertionFailure(e.localizedDescription)
                            }
                        }
                        self.selectedTags = []
                    }
                    
                }
                Button(L.cancelTitle, role: .cancel) {
                    isDeleteConfirmationPresented = false
                }
            }
    }
    
    func deselectTags() -> some View {
        BonsaiImage.unselect
            .onTapGesture {
                selectedTags = []
            }
            .foregroundColor(BonsaiColor.blueLight)
            .opacity(0.8)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(tags) { tag in
                            TagCellView(
                                isSelected: selectedTags.contains(tag),
                                tag: tag
                            )
                            .onTapGesture {
                                if selectedTags.append(tag).inserted == false {
                                    selectedTags.remove(tag)
                                }
                            }
                        } // ForEach
                    } // VStack
                    .padding(2)
                } // ScrollView
                .padding(.top, 24)
                .padding(.horizontal, 16)
            } // ZStack
            .navigationTitle(L.Tags.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text(L.saveTitle)
                            .foregroundColor(BonsaiColor.blueLight)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if tags.count != 0 {
                        deselectTags()
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
                    self.selectedTags.append(tag)
                    self.isPresented = false
                }
            }
        }
        .fullScreenCover(isPresented: $isSubscriptionPresented) {
            Subscriptions(isPresented: $isSubscriptionPresented)
        }
    }
    
}

struct TagsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TagsContainerView(
            selectedTags: .constant([]),
            isPresented: .constant(true)
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        .previewDisplayName("iPhone 12")
    }
}
