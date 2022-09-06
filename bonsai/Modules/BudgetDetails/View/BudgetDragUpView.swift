//
//  BudgetDragUpView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetDragUpView: View {
    static let height: CGFloat = 148
    var body: some View {
        VStack {
            BonsaiImage.arrowUpCircle
              .renderingMode(.template)
              .foregroundColor(Color.white)
              .padding(.bottom, 5)
            Text(LocalizeService.Drag_up_hint)
                .font(BonsaiFont.body_17)
                .foregroundColor(BonsaiColor.text)
        }
        .frame(height: Self.height)
    }
}

struct BudgetDragUpView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDragUpView()
    }
}
