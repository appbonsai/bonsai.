//
//  TitleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12.12.2021.
//

import SwiftUI

struct TitleView: View {

    @Binding var text: String

    var body: some View {
        HStack(spacing: 8) {
            BonsaiImage.textBubble
                .foregroundColor(BonsaiColor.purple3)
                .padding([.leading, .top, .bottom], 16)
            TextField("", text: $text)
                .font(BonsaiFont.body_17)
                .modifier(
                    PlaceholderStyle(
                        showPlaceHolder: text.isEmpty,
                        placeholder: "Title",
                        placeholderColor: BonsaiColor.prompt,
                        contentColor: BonsaiColor.purple3
                    )
                )
                .padding([.trailing], 16)
        }
        .background(BonsaiColor.card)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(text: .constant(""))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
