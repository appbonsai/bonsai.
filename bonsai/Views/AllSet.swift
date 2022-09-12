//
//  AllSet.swift
//  bonsai
//
//  Created by antuan.khoanh on 05/09/2022.
//

import SwiftUI

struct AllSet: View {
    
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    var body: some View {
        
        BonsaiColor.card
            .ignoresSafeArea()
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(BonsaiColor.purple4, lineWidth: 4)
            )
            .overlay(
                VStack {
                    Image("AllSet_1")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(width: 228, height: 228)
                    VStack {
                        Text("All Set!")
                            .padding(.top, 7)
                            .font(.system(size: 28).bold())
                            .padding(.bottom, 2)
                        Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim ")
                            .font(.system(size: 17))
                            .padding([.leading, .trailing], 28)
                        
                        ZStack {
                        RoundedRectangle(cornerRadius: 13)
                           .frame(width: 192, height: 48)
                           .foregroundColor(BonsaiColor.mainPurple)
                           .onTapGesture {
                               isPresented = false
                           }
                            Text("Close")
                                .foregroundColor(BonsaiColor.card)
                                .font(.system(size: 17))
                                .bold()
                        }.padding(.bottom, 24)

                    }
                })
            .frame(height: 456, alignment: .center)
            .cornerRadius(13)
            .padding([.leading, .trailing], 16)
    }
}

struct AllSet_Previews: PreviewProvider {
    static var previews: some View {
        AllSet(isPresented: .constant(true))
    }
}
