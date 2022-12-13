//
//  DragDownHintView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 2/11/22.
//

import SwiftUI

struct DragDownHintView: View {
    var body: some View {
        VStack {
            Text(LocalizedStringKey("Drag_down_hint"))
                .font(BonsaiFont.body_17)
                .foregroundColor(BonsaiColor.text)
                .shimmering(duration: 3.0)
           BonsaiImage.arrowUpCircle
             .renderingMode(.template)
             .foregroundColor(Color.white)
             .padding(.top, 5)
             .rotationEffect(.radians(.pi))
        }
    }
}
