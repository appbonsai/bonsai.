//
//  OnboardingCard.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct OnboardingCard: View {
    
    let dataSource: OnboardingDataSource
    
    init(dataSource: OnboardingDataSource) {
        self.dataSource = dataSource
    }
    
    var body: some View {
        VStack {
            ZStack {
                OnboardingCardGradiented(image: dataSource.image)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                VStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                        .foregroundColor(.clear)

                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey(dataSource.title))
                            .bold()
                            .font(.system(size: 28))
                            .foregroundColor(BonsaiColor.mainPurple)
                            .padding([.leading, .trailing], 32)
                            .padding(.bottom, 8)
                        Text(LocalizedStringKey(dataSource.description))
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
        OnboardingCard(dataSource: .init(image: "", title: "", description: ""))
    }
}
