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
                BonsaiColor.purple2
                    .ignoresSafeArea()
                VStack {
                    GifImage("new_operation")
                        .frame(width: UIScreen.main.bounds.width / 1.8, height: UIScreen.main.bounds.width * 1.1)
                    
                }
                .frame(height: UIScreen.main.bounds.width * 1.2)
            }

            VStack(alignment: .center) {
                Text("Unlimited transactions")
                    .font(.system(size: 17))
                    .foregroundColor(BonsaiColor.purple6)
                    .bold()
                    .padding([.top, .bottom], 4)
                Text("With a premium subscription you get unlimited access to the functionality.With a premium subscription you get unlimited access to the functionality.")
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .font(.system(size: 14))
                    .foregroundColor(BonsaiColor.purple6)
                
                ZStack {
                   RoundedRectangle(cornerRadius: 13)
                        .frame(width: 200, height: 48)
                      .foregroundColor(BonsaiColor.mainPurple)
                      .onTapGesture {
                          isPresented = false
                      }
                      
                    Text("OK")
                      .foregroundColor(BonsaiColor.card)
                      .font(.system(size: 17))
                      .bold()
                }
            }
        }
    }
}

struct PremiumDescription_Previews: PreviewProvider {
    static var previews: some View {
        PremiumDescription(isPresented: .constant(true))
    }
}
