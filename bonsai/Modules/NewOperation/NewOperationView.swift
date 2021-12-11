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

    init() {
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
                    }
                    .padding([.top, .leading, .trailing], 16)
                }
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
