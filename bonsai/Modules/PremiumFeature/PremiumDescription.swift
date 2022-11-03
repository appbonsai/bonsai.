//
//  PremiumDescription.swift
//  bonsai
//
//  Created by antuan.khoanh on 16/09/2022.
//

import SwiftUI

struct PremiumDescription: View {
    @Binding var isPresented: Bool
    @Binding private var premium: Premium
    
    init(isPresented: Binding<Bool>, premium: Binding<Premium>) {
        self._isPresented = isPresented
        self._premium = premium
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
                Text(premium.name)
                    .font(.system(size: 17))
                    .foregroundColor(BonsaiColor.purple6)
                    .bold()
                    .padding([.top, .bottom], 4)
                Text(premium.description)
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
                      
                   Text(L.ok)
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
        PremiumDescription(isPresented: .constant(true), premium: .constant(.init(name: "", description: "", icon: "")))
    }
}
