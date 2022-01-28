//
//  NewOperationView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

struct NewOperationView: View {

   @Binding var isPresented: Bool

   @State var selectedOperation: OperationType = .expense
   @State var amount: String = ""
   @State var category: Category?
   @State var title: String = ""
   @State var isCategoriesViewPresented: Bool = false

   init(isPresented: Binding<Bool>) {
      self._isPresented = isPresented
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
               VStack(alignment: .center, spacing: 0) {
                  OperationTypeSelectorView(
                     operations: [.expense, .income, .transfer],
                     selectedOperation: $selectedOperation
                  )
                     .padding([.bottom], 12)
                  AmountView(
                     operation: selectedOperation,
                     text: $amount
                  )
                     .cornerRadius(13)
                     .padding([.top], 12)
                  CategoryView(category: $category)
                     .cornerRadius(13, corners: [.topLeft, .topRight])
                     .padding([.top], 16)
                     .onTapGesture {
                        isCategoriesViewPresented = true
                     }

                  ZStack { // separator
                     BonsaiColor.card
                        .frame(height: 1)
                     BonsaiColor.separator
                        .frame(height: 1)
                        .padding([.leading, .trailing], 16)
                  }
                  TitleView(text: $title)
                     .cornerRadius(13, corners: [.bottomLeft, .bottomRight])
               }
               .padding([.top, .leading, .trailing], 16)
            }
         } // ZStack
         .navigationTitle("New Operation")
         .navigationBarTitleDisplayMode(.large)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               NavigationBackButton(isPresented: $isPresented)
            }
         }
      } // NavigationView
      .popover(isPresented: $isCategoriesViewPresented) {
         CategoriesContainerView(
            isPresented: $isCategoriesViewPresented,
            selectedCategory: $category
         )
      }
   }
}

struct NewOperationView_Previews: PreviewProvider {
   static var previews: some View {
      NewOperationView(isPresented: .constant(true))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
