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
    @State var premium: Premium = .init(name: "", description: "", icon: "", gifImage: "")

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
                   Text(L.premium_descriptions)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17))
                        .foregroundColor(BonsaiColor.purple6)
                        .padding([.top, .bottom], 12)
                }
                .padding([.leading, .trailing], 12)
                
                ForEach(Array(premiumFeatures.enumerated()), id: \.offset) { index, premium in
                    PremiumFeatureCell(premium: premium)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            self.premium = premiumFeatures[index]
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
    
    let premiumFeatures: [Premium] = [
      .init(
         name: L.Unlimited_categories,
         description: L.Unlimited_categories_descriptions,
         icon: "",
         gifImage: "new_category"
      ),
        .init(
         name: L.Unlimited_tags,
         description: L.Unlimited_tags_descriptions,
         icon: "",
         gifImage: "new_tag"
        ),
      .init(
         name: L.Flexible_budget,
         description: L.Flexible_budget_descriptions,
         icon: "",
         gifImage: "custom_budget"
      ),
        .init(
         name: L.No_ads,
         description: L.No_ads_descriptions,
         icon: "",
         gifImage: "no_ads"
        )
    ]
   
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
