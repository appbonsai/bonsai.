//
//  TagsView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 14.12.2021.
//

import SwiftUI

struct TagsView: View {
    var body: some View {
        HStack {
            Image(uiImage: BonsaiImage.tag)
                .resizable()
                .renderingMode(.template)
                .frame(width: 23, height: 23)
                .foregroundColor(BonsaiColor.purple2)
                .padding(.leading, 17)
            
            Text("Tags")
                .foregroundColor(BonsaiColor.prompt)
                .font(BonsaiFont.body_17)
                .padding(.vertical, 18)
            
            Spacer()
                
            BonsaiImage.chevronDown
                .foregroundColor(BonsaiColor.purple2)
                .padding(.trailing, 23)
        }
        .background(BonsaiColor.card)
        .cornerRadius(13)
        
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
            .previewLayout(.fixed(width: 458, height: 56))
    }
}
