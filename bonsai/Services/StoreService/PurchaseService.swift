//
//  PurchaseService.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import Foundation
import RevenueCat

final class PurchaseService {
   
   init() {
      
   }
   
   func getOfferings() {
      /*
       dispatching on main any publisher
       */
      var availablePackages: [Package] = []
      Purchases.shared.getOfferings { offerings, error in
         if let currentOffer = offerings?.current {
            availablePackages = currentOffer.availablePackages
         }
      }
   }
}


