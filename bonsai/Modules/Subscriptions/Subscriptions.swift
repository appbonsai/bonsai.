//
//  Subscriptions.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct Subscriptions: View {
   
   @State var id: String = MockSubscriptions.subscriptions.first(where: { $0.isMostPopular })?.id ?? ""
   
   let mockSubs = MockSubscriptions.subscriptions
   
   var body: some View {
      ZStack {
         BonsaiColor.back
            .ignoresSafeArea()
         List {
            HStack {
               Image("undraw_japan_ubgk 1")
                  .resizable()
                  .scaledToFill()
                  .clipped()
                  .padding([.leading, .trailing], 73)
            }
            .listRowBackground(BonsaiColor.back)
            .listRowSeparator(.hidden)
            .padding(.bottom, 12)
            .padding(.top, 20)
            HStack(alignment: .center) {
               Spacer()
               Text("Choose your plan")
                  .font(.system(size: 28))
                  .bold()
                  .foregroundColor(BonsaiColor.purple7)
               Spacer()
            }
            .listRowBackground(BonsaiColor.back)
            .padding(.bottom, 12)
            ForEach(0..<4) { index in
               SubscriptionCell(subscription: mockSubs[index], id: id)
                  .listRowSeparator(.hidden)
                  .onTapGesture {
                     let subscription = mockSubs[index]
                     id = subscription.id
                  }
            }
            .listRowBackground(BonsaiColor.back)
            
            
            let termsOfServiceUrl = "https://duckduckgo.com"
            let termsOfServicelink = "[Terms of Service](\(termsOfServiceUrl))"
            
            let privacyPolicyUrl = "https://duckduckgo.com"
            let privacyPolicylink = "[Privacy Policy](\(privacyPolicyUrl))"
            
            Group {
               Text("By subscribing you agree to our ") +
               Text(.init(termsOfServicelink)).foregroundColor(BonsaiColor.secondary) +
               Text(" and ") +
               Text(.init(privacyPolicylink)).foregroundColor(BonsaiColor.secondary) +
               Text(".")
            }
            .font(.system(size: 12))
            .lineLimit(3)
            .listRowSeparator(.hidden)
            .listRowBackground(BonsaiColor.back)
            
            Button {
               
            } label: {
               HStack(alignment: .center) {
                  Text("Restore Purchases")
                     .font(.system(size: 12))
                     .foregroundColor(BonsaiColor.secondary)
                  Spacer()
               }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(BonsaiColor.back)
            
            HStack(alignment: .center) {
               Spacer()
               ZStack {
                  RoundedRectangle(cornerRadius: 13)
                     .frame(width: 192, height: 48)
                     .foregroundColor(BonsaiColor.mainPurple)
                  Text("Get all features")
                     .foregroundColor(BonsaiColor.card)
                     .font(.system(size: 17))
                     .bold()
               }
               Spacer()
            }
            .padding(.bottom, 30)
            .listRowSeparator(.hidden)
            .listRowBackground(BonsaiColor.back)
         }
         .onAppear {
            UITableView.appearance().showsVerticalScrollIndicator = false
         }
         .listStyle(PlainListStyle())
         .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
      }
   }
}


struct Subscriptions_Previews: PreviewProvider {
   static var previews: some View {
      Subscriptions()
   }
}
