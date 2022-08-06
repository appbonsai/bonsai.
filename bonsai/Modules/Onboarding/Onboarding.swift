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
        ZStack {
            VStack {
                TabView(selection: $selection) {
                    OnboardingCard()
                    OnboardingCard()
                }
               
                Button {
                    print("press")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .frame(width: 192, height: 48)
                            .foregroundColor(BonsaiColor.mainPurple)
                            Text("Continue")
                            .foregroundColor(BonsaiColor.card)
                            .font(.system(size: 17))
                            .bold()
                    }
                }
                .padding(.bottom, 74)

            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .animation(.easeInOut)
            .ignoresSafeArea()
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
