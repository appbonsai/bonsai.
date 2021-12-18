//
//  TagView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 18.12.2021.
//

import SwiftUI

struct TagView: View {
    var title: String
    var isSelected: Bool = false
    var body: some View {
        HStack {
            Text(title)
                .font(BonsaiFont.caption_12)
                .padding(.vertical, 6)
                .padding(.leading, 12)
                .padding(.trailing, isSelected ? 0 : 12)
                .foregroundColor(isSelected ? BonsaiColor.card : BonsaiColor.text)
            
            if isSelected {
                BonsaiImage.xmark
                    .resizable()
                    .frame(width: 7, height: 7)
                    .padding(.leading, 11)
                    .padding(.trailing, 15)
                    .foregroundColor(BonsaiColor.card)
                    
            }
        }
        .background(isSelected ? BonsaiColor.mainPurple : BonsaiColor.disabled)
        .cornerRadius(24)
        
    }
    
    func didSelect() {
        
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(title: "Tag 1", isSelected: true)
    }
}
