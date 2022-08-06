//
//  Onboarding.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct Onboarding: View {
    
    @State private var selection = 1
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                Image("bonsai_1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .clipped()
                   
                Image("bonsai_2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .clipped()
                    
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .animation(.easeInOut)
        .padding(.top, 37 + 20)
        .background(BonsaiColor.back)
        .ignoresSafeArea()
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
