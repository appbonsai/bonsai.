//
//  OperationTypeSelectorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI
import OrderedCollections

struct OperationTypeSelectorView: View {

    typealias Operation = NewOperationView.OperationType

    let operations: OrderedSet<Operation>
    @Binding var selectedOperation: Operation

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(operations, id: \.self) { operation in
                OperationTypeView(
                    operation: operation,
                    isSelected: $selectedOperation.wrappedValue == operation
                ).onTapGesture {
                    selectedOperation = operation
                }
            }
        }
    }
}

struct OperationTypeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        OperationTypeSelectorView(
            operations: [.expense, .income, .transfer],
            selectedOperation: .constant(.expense)
        )
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
