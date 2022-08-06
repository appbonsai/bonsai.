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
            ZStack {
                TabView(selection: $selection) {
                    OnboardingCard()
                    
                    Image("bonsai_2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                        .clipped()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .animation(.easeInOut)
        .ignoresSafeArea()
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
