//
//  Onboarding.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct Onboarding: View {
    
    @State private var selection = 0
    
    private var onboardingImages = [
        "bonsai_1",
        "bonsai_2",
        "bonsai_3"
    ]
    
    @State var fadein: Bool = false
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ForEach(0..<onboardingImages.count, id: \.self) { index in
                    OnboardingCard(image: onboardingImages[index])
                        .tag(index)
                }
            }
            Button {
                if selection != onboardingImages.count - 1 {
                    withAnimation {
                        selection += 1
                    }
                    withAnimation(.easeInOut(duration: 0.3)) {
                        fadein.toggle()
                    }
                    withAnimation(.easeInOut(duration: 0.6)) {
                        fadein.toggle()
                    }
                } else {
                    // open MAIN SCREEN
                }
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
        .opacity(fadein ? 0.1 : 1.0)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .ignoresSafeArea()
    }
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
