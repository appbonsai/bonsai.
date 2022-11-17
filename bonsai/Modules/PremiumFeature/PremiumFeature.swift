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
   @State var premium: Premium = .init(name: "", description: "", icon: BonsaiImage.tag, gifImage: "")
   @EnvironmentObject var purchaseService: PurchaseService

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
                  Text(L.premiumDescriptions)
                     .frame(maxWidth: .infinity)
                     .multilineTextAlignment(.center)
                     .font(.system(size: 17))
                     .foregroundColor(BonsaiColor.purple6)
                     .padding([.top, .bottom], 12)
               }
               .padding([.leading, .trailing], 12)
               
               ForEach(Array(premiumFeatures().enumerated()), id: \.offset) { index, premium in
                  PremiumFeatureCell(premium: premium)
                     .listRowSeparator(.hidden)
                     .onTapGesture {
                        self.premium = premiumFeatures()[index]
                        isPresentedPremiumDescription = true
                     }
               }
            }
            .padding([.top, .bottom], 12)
         }
         .popover(isPresented: $isPresentedPremiumDescription) {
            PremiumDescription(
               isPresented:$isPresentedPremiumDescription,
               premium: $premium
            )
         }
      }
   }
   
   func premiumFeatures() -> [Premium] {
      
      var premiums: [Premium] = [
         .init(
            name: L.unlimitedCategories,
            description: L.unlimitedCategoriesDescriptions,
            icon: BonsaiImage.folder,
            gifImage: "new_category"
         ),
         .init(
            name: L.unlimitedTags,
            description: L.unlimitedTagsDescriptions,
            icon: BonsaiImage.tag,
            gifImage: "new_tag"
         ),
         .init(
            name: L.flexibleBudget,
            description: L.flexibleBudgetDescriptions,
            icon: BonsaiImage.calendar,
            gifImage: "custom_budget"
         ),
         .init(
            name: L.noAds,
            description: L.noAdsDescriptions,
            icon: BonsaiImage.star,
            gifImage: "no_ads"
         )
      ]
      
      if purchaseService.isUKRStoreFront {
         premiums.insert(
            .init(name: L.specialForUATitle,
                  description: L.specialForUA,
                  icon: Image.init("UA"),
                  gifImage: "ua23"),
            at: 0)
      }
      
      return premiums
   }
   
   
   /*
    //        .init(name: "Unlimited budgets", description: "Get unlimited opportunity to create budget for your needs", icon: "", gifImage: "new_tag"),
    //        .init(name: "Custom appearance", description: "Customize home background with your favourite tree, change icon of the app. ", icon: ""),
    */
}

struct PremiumFeature_Previews: PreviewProvider {
    static var previews: some View {
        PremiumFeature(isPresented: .constant(true))
    }
}
