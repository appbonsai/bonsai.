//
//  Onboarding.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct OnboardingDataSource {
    let image: String
    let title: String
    let description: String
}

struct Onboarding: View {
    
    @State private var selection = 0
    
    private let dataSource: [OnboardingDataSource] = [
        .init(
            image: "bonsai_1",
            title: "Why do we use it?",
            description: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation ve"),
        .init(
            image: "bonsai_2",
            title: "Where does it come from?",
            description: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "),
        .init(
            image: "bonsai_3",
            title: "Where can I get some?",
            description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    ]
    
    var body: some View {
        VStack {
            ZStack {
                
                if selection == 0 {
                    OnboardingCard(dataSource: dataSource[selection])
                } else if selection == 1 {
                    OnboardingCard(dataSource: dataSource[selection])
                } else if selection == 2 {
                    OnboardingCard(dataSource: dataSource[selection])
                }
                VStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
                        .foregroundColor(.clear)
                    Button {
                        if selection != dataSource.count - 1 {
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
                            Text(L.Continue_button)
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
