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
            ZStack {
                GifImage("2")
                    .frame(width: 200, height: 90)
            }
            VStack(alignment: .center) {
                Text("With a premium subscription you get unlimited access to the functionality.")
                    .frame(height: 50, alignment: .center)
                    .font(.system(size: 17))
                    .foregroundColor(BonsaiColor.purple6)
            }
            List {
                ForEach(Array(mockPremiums.enumerated()), id: \.offset) { index, premium in
                    PremiumFeatureCell(premium: premium)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                        }
                }
                .onAppear {
                    UITableView.appearance().showsVerticalScrollIndicator = false
                }
                .listStyle(.automatic)
            }
        }
        }
    }

struct PremiumFeature_Previews: PreviewProvider {
    static var previews: some View {
        PremiumFeature()
    }
}
