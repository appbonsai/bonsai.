//
//  CategoriesContainerView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 10.12.2021.
//

import SwiftUI

struct CategoriesContainerView: View {
    @State var selectedIndex = 0
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor(BonsaiColor.orange)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                
                VStack {
                    ForEach(0..<5) { index in
                        CategoriesCellView(isSelected: .constant(selectedIndex == index))
                            .padding(.bottom, 16)
                            .onTapGesture {
                                selectedIndex = index
                            }
                    }
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.horizontal, 16)
                .navigationTitle("Category")
                .toolbar {
                    Image(systemName: "plus")
                        .foregroundColor(BonsaiColor.mainPurple)
                }
            }
        }
    }
}

struct CategoriesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesContainerView()
    }
}
