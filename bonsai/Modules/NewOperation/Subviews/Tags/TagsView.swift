//
//  TagsView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 14.12.2021.
//

import SwiftUI

struct TagsView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
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
        
            BonsaiColor.separator
                .frame(height: 1)
                .padding(.horizontal, 16)
            
            
            VStack(alignment: .leading) {
                HStack() {
                    ForEach(0..<4) { i in
                        TagView(title: "Tag \(i)")
                    }
                }
                .padding(.leading, 16)
                .padding(.bottom, 16)
                .padding(.top, 8)
            }
        }
        .background(BonsaiColor.card)
        .cornerRadius(13)
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
            .previewLayout(.fixed(width: 458, height: 96))
    }
}
