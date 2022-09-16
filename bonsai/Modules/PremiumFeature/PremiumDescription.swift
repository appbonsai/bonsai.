//
//  PremiumDescription.swift
//  bonsai
//
//  Created by antuan.khoanh on 16/09/2022.
//

import SwiftUI

struct PremiumDescription: View {
    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            ZStack {
                GifImage("5")
                    .frame(height: 190)
            }
            VStack(alignment: .center) {
                Text("With a premium subscription you get unlimited access to the functionality.With a premium subscription you get unlimited access to the functionalityWith a premium subscription you get unlimited access to the functionalityWith a premium subscription you get unlimited access to the functionalityWith a premium subscription you get unlimited access to the functionality")
                    .font(.system(size: 17))
                    .foregroundColor(BonsaiColor.purple6)
            }
            .padding()
            Spacer()
        }
    }
}

struct PremiumDescription_Previews: PreviewProvider {
    static var previews: some View {
        PremiumDescription(isPresented: .constant(true))
    }
}
