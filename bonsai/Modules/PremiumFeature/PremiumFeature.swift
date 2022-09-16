//
//  PremiumFeature.swift
//  bonsai
//
//  Created by antuan.khoanh on 16/09/2022.
//

import SwiftUI

struct PremiumFeature: View {
    @Binding var isPresented: Bool
    @State var isPresentedPremiumDescription: Bool = false

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            ZStack {
                GifImage("4")
                    .frame(height: 190)
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
                            isPresentedPremiumDescription = true
                        }
                }
                .onAppear {
                    UITableView.appearance().showsVerticalScrollIndicator = false
                }
                .listStyle(.automatic)
            }
        }
        .popover(isPresented: $isPresentedPremiumDescription) {
            PremiumDescription(isPresented: $isPresentedPremiumDescription)
        }
    }
}

struct PremiumFeature_Previews: PreviewProvider {
    static var previews: some View {
        PremiumFeature(isPresented: .constant(true))
    }
}
