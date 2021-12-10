//
//  NewOperationView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

struct NewOperationView: View {

    @State var selectedOperation: OperationTypeSelectorView.Operation = .expense

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
                        Text("Type")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(BonsaiFont.title_22)
                            .foregroundColor(BonsaiColor.text)
                            .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 0))
                        OperationTypeSelectorView(
                            operations: [.expense, .income, .transfer],
                            selected: $selectedOperation
                        )
                    }
                    .padding(
                        .init(
                            top: 16,
                            leading: 16,
                            bottom: 0,
                            trailing: 16
                        )
                    )
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
