//
//  PurchaseService.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import Foundation
import RevenueCat
import Combine
import SwiftUI

final class PurchaseService: ObservableObject {
   
   private struct Pro {
      static var typeName: String {
         return String(describing: Self.self)
      }
   }
   
   @Published var availablePackages: [Package] = []
   @Published var isSubscriptionActive = false

   private var disposeBag = Set<AnyCancellable>()
   
   init() {
      checkIfUserSubscriptionStatus()
      getAvailablePackagesFromOfferings()
         .receive(on: RunLoop.main)
         .sink(receiveCompletion: { error in
            print("error \(error)")
         }, receiveValue: { pkg in
            self.availablePackages = pkg
         })
         .store(in: &disposeBag)
   }
   
   private func checkIfUserSubscriptionStatus() {
      Purchases.shared.getCustomerInfo { customerInfo, error in
         self.isSubscriptionActive = customerInfo?.entitlements.all[Pro.typeName]?.isActive == true
      }
   }
   
   func buy(package: Package?) {
      if let package = package {
         Purchases.shared.purchase(package: package) { storeTransaction, customerInfo, error, bool in
            if let error = error {
                assert(false, error.localizedDescription)
            }
             
            if let allEntitlements = customerInfo?.entitlements.all[Pro.typeName] {
               self.isSubscriptionActive = allEntitlements.isActive
            }
         }
      }
   }
   
   func restorePurchase() {
      Purchases.shared.restorePurchases { customerInfo, error in
         if let error = error {
             assert(false, error.localizedDescription)
         }
         if let allEntitlements = customerInfo?.entitlements.all[Pro.typeName] {
            self.isSubscriptionActive = allEntitlements.isActive
         } else {
            self.isSubscriptionActive = false
         }
      }
   }
   
   private func getAvailablePackagesFromOfferings() -> AnyPublisher<[Package], Error> {
      Future { promise in
         Purchases.shared.getOfferings { offerings, error in
            if let error = error {
               promise(.failure(error))
            }
            if let currentOffer = offerings?.current {
               let pakages = currentOffer.availablePackages
               promise(.success(pakages))
            }
         }
      }.eraseToAnyPublisher()
   
   }
}

