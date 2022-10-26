//
//  BarDetailLabel.swift
//  bonsai
//
//  Created by Максим Алексеев  on 08.07.2022.
//

import SwiftUI

struct BarDetailLabel: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(BonsaiFont.caption_11)
            .foregroundColor(color)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(color, lineWidth: 1)
            )
        
    }
}

struct BarDetailLabel_Previews: PreviewProvider {
    static var previews: some View {
        BarDetailLabel(title: "$8.46K", color: BonsaiColor.mainPurple)
    }
}
