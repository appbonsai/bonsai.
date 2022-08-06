//
//  Subscriptions.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct Subscriptions: View {
    var body: some View {
        
        List {
            HStack(alignment: .center) {
                Spacer()
                Text("Choose your plan")
                Spacer()
            }
            ForEach(0..<4) { index in
                SubscriptionCell()
            }
            
            Text("By subscribing you agree to our Terms of Service and Privacy Policy.")
            
            Button {
                
            } label: {
                Text("Restore Purchases")
            }

            
            HStack(alignment: .center) {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: 192, height: 48)
                        .foregroundColor(BonsaiColor.mainPurple)
                    Text("Get all feutures")
                        .foregroundColor(BonsaiColor.card)
                        .font(.system(size: 17))
                        .bold()
                }
                Spacer()
            }
        }
    }
}

struct Subscriptions_Previews: PreviewProvider {
    static var previews: some View {
        Subscriptions()
    }
}
