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
        ZStack {
            Color.black
              .ignoresSafeArea()
        VStack {
            ZStack {
                GifImage("5555")
                    .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.width / 2)
            }

            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    Text("With a premium subscription you get unlimited access to the functionality.")
                        .font(.system(size: 17))
                        .foregroundColor(BonsaiColor.purple6)
                        .padding([.top, .bottom], 12)
                }
                .padding([.leading, .trailing], 12)
                
                ForEach(Array(mockPremiums.enumerated()), id: \.offset) { index, premium in
                    PremiumFeatureCell(premium: premium)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            isPresentedPremiumDescription = true
                        }
                }
            }
            .padding([.top, .bottom], 12)
        }
        .popover(isPresented: $isPresentedPremiumDescription) {
            PremiumDescription(isPresented: $isPresentedPremiumDescription)
        }
        }
    }
}

struct PremiumFeature_Previews: PreviewProvider {
    static var previews: some View {
        PremiumFeature(isPresented: .constant(true))
    }
}
