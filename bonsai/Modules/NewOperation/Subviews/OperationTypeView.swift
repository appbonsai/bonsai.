//
//  OperationTypeView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

struct OperationTypeView: View {
    let operation: NewOperationView.OperationType
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Spacer(minLength: 4)
            operation.viewModel.image
                .foregroundColor({
                    if isSelected {
                        return BonsaiColor.mainPurple
                    } else {
                        return operation.viewModel.color
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
