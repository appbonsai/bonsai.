//
//  CategoriesCellView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 11.12.2021.
//

import SwiftUI

struct CategoriesCellView: View {
    @Binding var isSelected: Bool 
    var body: some View {
        HStack {
            Image(uiImage: BonsaiImage.fuelpump)
                .renderingMode(isSelected ? .template : .original)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(BonsaiColor.mainPurple)
                .padding(.trailing, 13)
            
            Text("Fuel")
                .foregroundColor(isSelected ? BonsaiColor.mainPurple : BonsaiColor.text)
                .font(BonsaiFont.title_headline_17)
            
            Spacer()
        }
        .padding([.vertical, .leading], 20)
        .background(BonsaiColor.card)
        .cornerRadius(13)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(BonsaiColor.mainPurple, lineWidth: isSelected ? 2 : 0)
        )
        
    }
}

struct CategoriesCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesCellView(isSelected: .constant(false))
    }
}
