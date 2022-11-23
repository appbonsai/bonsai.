//
//  SegmentControlView.Item.swift
//  bonsai
//
//  Created by Vladimir Korolev on 10.12.2021.
//

import SwiftUI

extension SegmentControlView {

    struct Item: View {

        struct Model: Identifiable, Equatable {
            let id: String
            let image: Image
            let imgColor: Color
            let text: String
        }
        let model: Model
        let isSelected: Bool

        var body: some View {
            HStack(alignment: .center, spacing: 8) {
                Spacer(minLength: 4)
                model.image
                    .foregroundColor(model.imgColor)
                Text(model.text)
                    .font(BonsaiFont.subtitle_15)
                    .foregroundColor(BonsaiColor.text)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer(minLength: 4)
            } // HStack
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
            ) // overlay
        }
    }
}
