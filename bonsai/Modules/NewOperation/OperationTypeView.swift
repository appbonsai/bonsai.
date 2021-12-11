//
//  OperationTypeView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

extension OperationTypeView {
    enum OperationType {
        case expense
        case income
        case transfer
    }
}

struct OperationTypeView: View {
    private let operation: OperationType
    private let isSelected: Bool

    init(operation: OperationType, isSelected: Bool) {
        self.operation = operation
        self.isSelected = isSelected
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Spacer(minLength: 4)
            operation.viewModel.image
                .foregroundColor({
                    if isSelected {
                        return BonsaiColor.mainPurple
                    } else {
                        return operation.viewModel.imageColor
                    }
                }())
                .padding([.top, .bottom], 7)
            Text(operation.viewModel.title)
                .font(BonsaiFont.subtitle_15)
                .foregroundColor({
                    if isSelected {
                        return BonsaiColor.mainPurple
                    } else {
                        return BonsaiColor.text
                    }
                }())
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer(minLength: 4)
        }
        .background(BonsaiColor.card)
        .cornerRadius(13)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(
                    { () -> Color in
                        if isSelected {
                            return BonsaiColor.mainPurple
                        } else {
                            return .clear
                        }
                    }(),
                    lineWidth: 2
                )
        )
    }
}

struct OperationTypeView_Previews: PreviewProvider {
    static var previews: some View {
        OperationTypeView(
            operation: .expense,
            isSelected: false
        )
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}

fileprivate extension OperationTypeView.OperationType {
    struct ViewModel {
        let imageColor: Color
        let image: Image
        let title: String
    }

    var viewModel: ViewModel {
        switch self {
        case .expense:
            return .init(
                imageColor: BonsaiColor.secondary,
                image: Image(uiImage: Asset.trendingDown.image),
                title: "Expense"
            )
        case .income:
            return .init(
                imageColor: BonsaiColor.green,
                image: Image(uiImage: Asset.trendingUp.image),
                title: "Revenue"
            )
        case .transfer:
            return .init(
                imageColor: BonsaiColor.blue,
                image: Image(uiImage: Asset.trendingFlat.image),
                title: "Transfer"
            )
        }
    }
}
