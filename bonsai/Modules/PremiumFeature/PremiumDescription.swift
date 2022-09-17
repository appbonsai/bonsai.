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
                GifImage("new_operation")
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.width * 1.3)
            }

            VStack(alignment: .center) {
                Text("Unlimited transactions")
                    .font(.system(size: 17))
                    .foregroundColor(BonsaiColor.purple6)
                    .bold()
                    .padding()
                Text("With a premium subscription you get unlimited access to the functionality.With a premium subscription you get unlimited access to the functionality.")
                    .font(.system(size: 14))
                    .foregroundColor(BonsaiColor.purple6)
                    .padding(.bottom, 16)
                
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
            .padding()
        }
    }
}

struct PremiumDescription_Previews: PreviewProvider {
    static var previews: some View {
        PremiumDescription(isPresented: .constant(true))
    }
}
