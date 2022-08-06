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
            OnboardingCardGradiented()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8, alignment: .bottom)
            VStack {
                Text("SOME SDKASODKALSD DSLD")
                Text("SOME SDKASODKALSD DSLD")
            }
        }
        .ignoresSafeArea()
    }
}

struct OnboardingCard_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCard()
    }
}
