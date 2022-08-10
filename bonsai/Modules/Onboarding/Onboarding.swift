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
    
    var body: some View {
        VStack {
            ZStack {
                
                    if selection == 0 {
                        OnboardingCard(image: "bonsai_1")
                    } else if selection == 1 {
                        OnboardingCard(image: "bonsai_2")
                    } else if selection == 2 {
                        OnboardingCard(image: "bonsai_3")
                    }
                VStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
                        .foregroundColor(.clear)
                    Button {
                        if selection != onboardingImages.count - 1 {
                            withAnimation(.easeInOut(duration: 0.7)) {
                                selection += 1
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
                }
                
            }
            
        }
        .ignoresSafeArea()
    }
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
