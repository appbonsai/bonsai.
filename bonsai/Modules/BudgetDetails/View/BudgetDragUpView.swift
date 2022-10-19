//
//  BudgetDragUpView.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI

struct BudgetDragUpView: View {
    var body: some View {
        VStack {
            BonsaiImage.arrowUpCircle
              .renderingMode(.template)
              .background(Color.white)
            
            //Need to update asset white system arrow doesnt match
            
            Text("Drag up to see your last operations")
                .font(BonsaiFont.body_17)
                .foregroundColor(BonsaiColor.text)
        }
    }
}

struct BudgetDragUpView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDragUpView()
    }
}
