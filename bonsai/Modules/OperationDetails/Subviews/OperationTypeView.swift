//
//  OperationTypeView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

struct OperationTypeView: View {
    let operation: OperationDetails.OperationType
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Spacer(minLength: 4)
            operation.viewModel.image
                .foregroundColor(operation.viewModel.color)
            Text(operation.viewModel.title)
                .font(BonsaiFont.subtitle_15)
                .foregroundColor(BonsaiColor.text)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer(minLength: 4)
        }
        .padding(.vertical, 12)
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
