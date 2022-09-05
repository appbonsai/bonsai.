//
//  AllSet.swift
//  bonsai
//
//  Created by antuan.khoanh on 05/09/2022.
//

import SwiftUI

struct AllSet: View {
    var body: some View {
        
        BonsaiColor.card
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Image("AllSet_1")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(width: 228, height: 228)
                    VStack {
                        Text("All Set!")
                            .padding(.top, 7)
                            .font(.system(size: 28).bold())
                            .padding(.bottom, 2)
                        Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim ")
                            .font(.system(size: 17))
                            .padding([.leading, .trailing], 28)
                    }
                })
    }
}

struct AllSet_Previews: PreviewProvider {
    static var previews: some View {
        AllSet()
    }
}
