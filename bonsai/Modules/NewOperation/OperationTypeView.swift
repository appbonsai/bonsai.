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
            operation.image
                .foregroundColor({
                    if isSelected {
                        return BonsaiColor.mainPurple
                    } else {
                        return operation.imageColor
                    }
                }())
                .padding([.top, .bottom], 7)
            Text(operation.title)
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
    var imageColor: Color {
        switch self {
        case .expense:
            return BonsaiColor.secondary
        case .income:
            return BonsaiColor.green
        case .transfer:
            return BonsaiColor.blue
        }
    }

    var image: Image {
        switch self {
        case .expense:
            return Image(uiImage: Asset.trendingDown.image)
        case .income:
            return Image(uiImage: Asset.trendingUp.image)
        case .transfer:
            return Image(uiImage: Asset.trendingFlat.image)
        }
    }

    var title: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Revenue"
        case .transfer:
            return "Transfer"
        }
    }
}
