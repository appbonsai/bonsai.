//
//  PremiumFeature.swift
//  bonsai
//
//  Created by antuan.khoanh on 16/09/2022.
//

import SwiftUI

struct PremiumFeature: View {
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    GifImage("2")
                        .frame(height: 190)
                    
                    VStack {
                        HStack {
                            BonsaiImage.xmarkSquare
                                .renderingMode(.template)
                                .foregroundColor(BonsaiColor.mainPurple)
                                .font(.system(size: 28))
                            
                            Spacer()
                        }
                        Spacer()
                    }.onTapGesture {
                    }
                }
            }
            .listRowBackground(BonsaiColor.back)
            .listRowSeparator(.hidden)
            .padding(.bottom, 12)
            .padding(.top, 20)
            HStack(alignment: .center) {
               Spacer()
                VStack(alignment: .center) {
                    
                    Text(L.Choose_your_plan)
                        .font(.system(size: 17))
                        .bold()
                        .foregroundColor(BonsaiColor.purple6)
                    
                    Text("With a premium subscription you get unlimited access to the functionality.")
                        .frame(height: 50, alignment: .center)
                        .font(.system(size: 17))
                        .foregroundColor(BonsaiColor.purple6)
                        .padding(.top, -2)

                }
               Spacer()
            }
            .listRowBackground(BonsaiColor.back)
            .padding(.bottom, 12)
            List {
                ForEach(Array(mockPremiums.enumerated()), id: \.offset) { index, premium in
                    
                    PremiumFeatureCell(premium: premium)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                        }
                }
                .listRowBackground(BonsaiColor.back)                
            }
        }
    }
}

struct PremiumFeature_Previews: PreviewProvider {
    static var previews: some View {
        PremiumFeature()
    }
}
