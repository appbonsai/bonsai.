//
//  PlaceholderStyle.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12.12.2021.
//

import SwiftUI

struct PlaceholderStyle: ViewModifier {
    let showPlaceHolder: Bool
    let placeholder: String
    let placeholderColor: Color
    let contentColor: Color

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
            }
            content
                .foregroundColor(contentColor)
        }
    }
}
