//
//  NewOperationView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

struct NewOperationView: View {
    
    @State var selectedOperation: OperationType = .expense
    @State var amount: String = ""
    @State var category: Category?
    @State var title: String = ""
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                
                List {
                    Section {
                        AmountView(
                            operation: selectedOperation,
                            text: $amount
                        )
                    }
                    .listRowInsets(EdgeInsets())
                    
                    Section {
                        CategoryView(category: $category)
                        TitleView(text: $title)

                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorTint(BonsaiColor.separator)
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("New Operation")
        }
    }

}

struct NewOperationView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
