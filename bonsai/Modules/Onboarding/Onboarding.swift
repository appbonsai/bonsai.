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
   @State var isPresenting = false

   private let dataSource: [OnboardingDataSource] = [
      .init(
         image: "bonsai_1",
         title: L.onboarding1Title,
         description: L.onboarding1Description),
      .init(
         image: "bonsai_2",
         title: L.onboarding2Title,
         description: L.onboarding2Description),
      .init(
         image: "bonsai_3",
         title: L.onboarding3Title,
         description: L.onboarding3Description),
   ]

   var body: some View {
      NavigationView {
          VStack {
              NavigationLink(
                destination: TabBar().navigationBarHidden(true), isActive: $isPresenting) { }
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
                     .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height * 0.8)
                     .foregroundColor(.clear)
                  Button {
                     if selection != dataSource.count - 1 {
                        withAnimation(.easeInOut(duration: 0.7)) {
                           selection += 1
                        }
                     } else {
                        UserSettings.isOnboardingSeen = true
                        isPresenting = true
                     }
                  } label: {
                     ZStack {
                        RoundedRectangle(cornerRadius: 13)
                           .frame(width: 192, height: 48)
                           .foregroundColor(BonsaiColor.mainPurple)
                        Text(L.continueButton)
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

}

struct Onboarding_Previews: PreviewProvider {
   static var previews: some View {
      Onboarding()
   }
}
