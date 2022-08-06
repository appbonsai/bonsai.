//
//  OnboardingCard.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct OnboardingCardGradiented: View {
    
    let image: String
    
    init(image: String) {
        self.image = image
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.75)
                    .clipped()
                    .overlay {
                        LinearGradient(
                            gradient: graidients,
                            startPoint: .top,
                            endPoint: .bottom)
                }
            }
        }
    }
    
    let graidients: Gradient =
        Gradient(stops: [
            .init(color: BonsaiColor.card.opacity(0), location: 0.2),
            .init(color: BonsaiColor.card.opacity(0.5), location: 0.5),
            .init(color: .black.opacity(1), location: 1)
        ])
    
}

struct OnboardingCardGradiented_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardGradiented(image: "bonsai_1")
    }
}
