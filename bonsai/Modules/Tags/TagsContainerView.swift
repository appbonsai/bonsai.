//
//  TagsContainerView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.06.2022.
//

import SwiftUI
import OrderedCollections

struct TagsContainerView: View {

   @FetchRequest(sortDescriptors: []) var tags: FetchedResults<Tag>
   @Binding var selectedTags: OrderedSet<Tag>
   @Binding var isPresented: Bool
   @State var isCreateTagPresented: Bool = false

   init(isPresented: Binding<Bool>,
        selectedTags: Binding<OrderedSet<Tag>>
   ) {
      self._isPresented = isPresented
      self._selectedTags = selectedTags
      UINavigationBar
         .appearance()
         .titleTextAttributes = [.foregroundColor: UIColor.white]
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
                        isSelected: tags.contains(tag),
                        tag: tag
                     )
                     .onTapGesture {
                        if selectedTags.append(tag).inserted == false {
                           selectedTags.remove(tag)
                        }
                     }
                  } // ForEach
               } // VStack
            } // ScrollView
            .padding(.top, 24)
            .padding(.horizontal, 16)
         } // ZStack
         .navigationTitle("Tags")
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               NavigationBackButton(isPresented: $isPresented)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
               Button(action: {
                  isCreateTagPresented = true
               }) {
                  Image(systemName: "plus")
                     .foregroundColor(BonsaiColor.mainPurple)
               }
            }
         }
      } // NavigationView
//      .popover(isPresented: $isCreateCategoryPresented) {
//         CreateCategoryView(isPresented: $isCreateCategoryPresented)
//      }
   }
}

struct TagsContainerView_Previews: PreviewProvider {
   static var previews: some View {
      TagsContainerView(
         isPresented: .constant(true),
         selectedTags: .constant([])
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
