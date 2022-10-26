//
//  BudgetNameView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetNameView: View {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(name)
                .font(BonsaiFont.title_28)
                .foregroundColor(BonsaiColor.text)
                .padding(.leading, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BudgetNameView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetNameView(name: "Summer Budget")
            .background(BonsaiColor.card)
    }
}
