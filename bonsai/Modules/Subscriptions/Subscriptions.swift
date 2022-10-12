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
   @State var isFeaturePremiumPresented: Bool = false
   @EnvironmentObject private var purchaseService: PurchaseService

   init(isPresented: Binding<Bool>) {
      self._isPresented = isPresented
      UINavigationBar.changeAppearance(clear: true)
   }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $isShowActivityIndicator) {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        gifView()
                            .padding(.bottom, 12)
                            .padding(.top, 20)
                        
                        planDescription()
                            .padding(.bottom, 12)
                        
                        purchaseProducts()
                            .padding(.horizontal)
                        
                        textGroup()
                            .padding(.horizontal)
                        
                        Button {
                            
                        } label: {
                            restorePurchase()
                                .padding()
                        }
                        
                        continueButton()
                            .padding(.bottom, 30)
                    }
                    .ignoresSafeArea()
                }
                
            }
            .popover(isPresented: $isFeaturePremiumPresented) {
                PremiumFeature(isPresented: $isFeaturePremiumPresented)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .foregroundColor(BonsaiColor.secondary)
                    }
                }
            }
        }
        
    }
    
    private func purchaseProducts() -> some View {
        ForEach(Array(purchaseService.viewModel.createSubscriptions().enumerated()), id: \.offset) { index, subscription in
            SubscriptionCell(
                subscription: subscription, id: id
            )
            .onTapGesture {
                id = subscription.id
            }
        }
    }
   
   private func restorePurchase() -> some View {
      HStack(alignment: .center) {
         Text(L.Restore_Purchases)
            .font(.system(size: 14))
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
    
    private func gifView() -> some View {
        HStack {
            ZStack {
                GifImage("6666")
                    .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.width / 2)
            }
        }
    }
    
    private func continueButton() -> some View {
        HStack(alignment: .center) {
           Spacer()
           ZStack {
              RoundedRectangle(cornerRadius: 13)
                   .frame(width: continueWidthButton(), height: 48)
                 .foregroundColor(BonsaiColor.mainPurple)
                 .onTapGesture {
                    
                    let package = purchaseService
                         .viewModel.packages
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
    }
    
    private func planDescription() -> some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Text(L.Choose_your_plan)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(BonsaiColor.purple6)
                
                Text("With a premium subscription you get unlimited access to the functionality.")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundColor(BonsaiColor.purple6)
                    .padding(.top, -2)
                    .padding(.horizontal)
                let learnMore = Text("Learn more")
                    .bold()
                    .foregroundColor(BonsaiColor.blueLight)
                    .shimmering(duration: 2.5)
                
                learnMore.onTapGesture {
                    isFeaturePremiumPresented = true
                }
            }
            Spacer()
        }
    }
    
    private func textGroup() -> some View {
        let termsOfServiceUrl = "https://duckduckgo.com"
        let termsOfServicelink = "[\(L.Terms_of_Service)](\(termsOfServiceUrl))"
        
        let privacyPolicyUrl = "https://duckduckgo.com"
        let privacyPolicylink = "[\(L.Privacy_Policy)](\(privacyPolicyUrl))"
        
        let text =
        Text(L.Subscription_description) +
        Text(.init(termsOfServicelink)).foregroundColor(BonsaiColor.secondary).bold() +
        Text(L.Merge_And) +
        Text(.init(privacyPolicylink))
            .foregroundColor(BonsaiColor.secondary).bold() +
        Text(".")
        return text
            .font(.system(size: 14))
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)            
    }
    
    private func continueWidthButton() -> CGFloat {
        let flexibleWidth: CGFloat = L.Try_for_free.widthOfString(usingFont: .systemFont(ofSize: 17), inset: 30)
        let standart: CGFloat = 200
        return flexibleWidth > standart ? flexibleWidth : standart
    }
    
}


struct Subscriptions_Previews: PreviewProvider {
   static var previews: some View {
      Subscriptions(isPresented: .constant(false))
           .environmentObject(PurchaseService())
   }
}


