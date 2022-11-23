//
//  SegmentControlView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

struct SegmentControlView: View {

    let models: [Item.Model]
    @Binding var selectedItem: Item.Model

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ForEach(models) { model in
                Item(model: model,
                     isSelected: selectedItem == model)
                .onTapGesture {
                    selectedItem = model
                }
            } // ForEach
        } // HStack
    }
}

extension OperationDetails.OperationType {
    var toSegmentedControlItemModel: SegmentControlView.Item.Model {
        SegmentControlView.Item.Model(
            id: rawValue,
            image: viewModel.image,
            imgColor: viewModel.color,
            text: viewModel.title
        )
    }
}

extension SegmentControlView {

    static func with(
        operations: [OperationDetails.OperationType],
        selectedOperation: Binding<OperationDetails.OperationType>
    ) -> SegmentControlView {
        SegmentControlView(
            models: operations.map { $0.toSegmentedControlItemModel },
            selectedItem: Binding<Item.Model>.init(
                get: {
                    selectedOperation.wrappedValue.toSegmentedControlItemModel
                },
                set: { model in
                    selectedOperation.wrappedValue = .init(rawValue: model.id) ?? .expense
                }
            )
        )
    }
}

struct SegmentControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControlView.with(
            operations: [.expense, .income, .transfer],
            selectedOperation: .constant(.expense)
        )
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
