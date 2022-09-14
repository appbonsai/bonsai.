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
   
   @Published var availablePackages: ([Package], [Subscription]) = ([], [])
   @Published var isSubscriptionActive = false
   @Published var isShownAllSet = false
    
   private let subscriptionViewModel: SubscriptionViewModel = .init()

   private var disposeBag = Set<AnyCancellable>()
   
   init() {
      checkIfUserSubscriptionStatus()
      getAvailablePackagesFromOfferings()
         .receive(on: RunLoop.main)
         .sink(receiveCompletion: { error in
            print("error \(error)")
         }, receiveValue: { [weak self] pkg in
             
             let subscriptions = self?.subscriptionViewModel.setSubscriptions(packages: pkg) ?? []
             self?.availablePackages = (pkg, subscriptions)
         })
         .store(in: &disposeBag)
   }
   
   func checkIfUserSubscriptionStatus() {
      Purchases.shared.getCustomerInfo { customerInfo, error in
         self.isSubscriptionActive = customerInfo?.entitlements.all[Pro.typeName]?.isActive == true
      }
   }
   
    func buy(package: Package?, completion: @escaping () -> Void) {
      if let package = package {
         Purchases.shared.purchase(package: package) { storeTransaction, customerInfo, error, bool in
            if let error = error {
                print(error.localizedDescription)
                completion()
            }
            if let allEntitlements = customerInfo?.entitlements.all[Pro.typeName] {
               self.isSubscriptionActive = allEntitlements.isActive
                self.isShownAllSet = allEntitlements.isActive
                completion()
            }
         }
      }
   }
   
    func restorePurchase(completion: @escaping () -> Void) {
      Purchases.shared.restorePurchases { customerInfo, error in
         if let error = error {
             print(error.localizedDescription)
             completion()
         }
         if let allEntitlements = customerInfo?.entitlements.all[Pro.typeName] {
            self.isSubscriptionActive = allEntitlements.isActive
             self.isShownAllSet = allEntitlements.isActive
             completion()
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

