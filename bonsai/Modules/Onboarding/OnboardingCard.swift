//
//  OnboardingCard.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct OnboardingCard: View {
    
    let image: String
    
    init(image: String) {
        self.image = image
    }
    
    var body: some View {
        VStack {
            ZStack {
                OnboardingCardGradiented(image: image)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                VStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                        .foregroundColor(.clear)

                    VStack(alignment: .leading) {
                        Text("Parturient Venenatis Etiam")
                            .bold()
                            .font(.system(size: 28))
                            .foregroundColor(BonsaiColor.mainPurple)
                            .padding([.leading, .trailing], 32)
                            .padding(.bottom, 8)
                        Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation ve")
                            .font(.system(size: 15))
                            .padding([.leading, .trailing], 32)
                            .padding(.bottom, 40)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct OnboardingCard_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCard(image: "bonsai_1")
    }
}
