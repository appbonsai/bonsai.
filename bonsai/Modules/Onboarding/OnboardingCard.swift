//
//  OnboardingCard.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct OnboardingCard: View {
    var body: some View {
        
        VStack {
            ZStack {
                Image("bonsai_1")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.9)
                            
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Parturient Venenatis Etiam")
                        .padding(.leading, 20)
                        .padding(.bottom, 8)
                        .foregroundColor(BonsaiColor.mainPurple)
                        .font(
                            .system(size: 28)
                            .bold())
                        .lineLimit(2)
                    
                    Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation ve")
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, -UIScreen.main.bounds.size.height * 0.2)
        }
    }
}

struct OnboardingCard_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCard()
    }
}
