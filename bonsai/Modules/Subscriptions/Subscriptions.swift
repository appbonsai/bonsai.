//
//  Subscriptions.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI
import RevenueCat

struct Subscriptions: View {
   @State var isShowActivityIndicator = false
   @State var id: String = ""
   @Binding var isPresented: Bool
   @EnvironmentObject private var purchaseService: PurchaseService

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
      
   var body: some View {
       LoadingView(isShowing: $isShowActivityIndicator) {
      ZStack {
         BonsaiColor.back
            .ignoresSafeArea()
         List {
            HStack {
                ZStack {
                    Image("undraw_japan_ubgk 1")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .padding([.leading, .trailing], 73)
                    VStack {
                        HStack {
                            BonsaiImage.xmarkSquare
                                .renderingMode(.template)
                                .foregroundColor(BonsaiColor.mainPurple)
                                .font(.system(size: 28))
                            
                            Spacer()
                        }
                        Spacer()
                    }.onTapGesture {
                        isPresented = false
                    }
                }
            }
            .listRowBackground(BonsaiColor.back)
            .listRowSeparator(.hidden)
            .padding(.bottom, 12)
            .padding(.top, 20)
            HStack(alignment: .center) {
               Spacer()
                Text(L.Choose_your_plan)
                  .font(.system(size: 28))
                  .bold()
                  .foregroundColor(BonsaiColor.purple6)
               Spacer()
            }
            .listRowBackground(BonsaiColor.back)
            .padding(.bottom, 12)
            
            ForEach(Array(purchaseService.availablePackages.enumerated()), id: \.offset) { index, pkg in
               
               let storeProduct = pkg.storeProduct
               let productId = storeProduct.productIdentifier
               let periodName = storeProduct.subscriptionPeriod!.periodTitle
               let price = storeProduct.localizedPriceString
               let isMostPopular = storeProduct.subscriptionPeriod?.unit == .year
               
               let subscription = Subscription(
                  id: productId,
                  periodName: periodName,
                  price: price,
                  isMostPopular: isMostPopular)
               
               SubscriptionCell(
                  subscription: subscription, id: id)
               .listRowSeparator(.hidden)
               .onTapGesture {
                  id = pkg.storeProduct.productIdentifier
               }
            }
            .listRowBackground(BonsaiColor.back)
            
            let termsOfServiceUrl = "https://duckduckgo.com"
             let termsOfServicelink = "[\(L.Terms_of_Service)](\(termsOfServiceUrl))"
            
            let privacyPolicyUrl = "https://duckduckgo.com"
             let privacyPolicylink = "[\(L.Privacy_Policy)](\(privacyPolicyUrl))"
            
            Group {
                Text(L.Subscription_description) +
               Text(.init(termsOfServicelink)).foregroundColor(BonsaiColor.secondary) +
                Text(L.Merge_And) +
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
                   Text(L.Restore_Purchases)
                     .font(.system(size: 12))
                     .foregroundColor(BonsaiColor.secondary)
                     .onTapGesture {
                         isShowActivityIndicator = true
                         purchaseService.restorePurchase {
                             isShowActivityIndicator = false
                             isPresented = false
                         }
                     }
                  Spacer()
               }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(BonsaiColor.back)
            
            HStack(alignment: .center) {
               Spacer()
               ZStack {
                  RoundedRectangle(cornerRadius: 13)
                       .frame(width: continueWidthButton(), height: 48)
                     .foregroundColor(BonsaiColor.mainPurple)
                     .onTapGesture {
                        
                        let package = purchaseService
                           .availablePackages
                           .first(where: {
                              id.isEmpty ?
                              $0.storeProduct.subscriptionPeriod?.unit == .year :
                              $0.storeProduct.productIdentifier == id
                           })

                         isShowActivityIndicator = true
                         purchaseService.buy(package: package, completion: {
                            isShowActivityIndicator = false
                            isPresented = false
                         })
                     }
                     
                   Text(L.Try_for_free)
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
    
    private func continueWidthButton() -> CGFloat {
        let flexibleWidth: CGFloat = L.Try_for_free.widthOfString(usingFont: .systemFont(ofSize: 17), inset: 20)
        let standart: CGFloat = 192
        return flexibleWidth > standart ? flexibleWidth : standart
    }
   
}


struct Subscriptions_Previews: PreviewProvider {
   static var previews: some View {
       Subscriptions(isPresented: .constant(false))
   }
}


