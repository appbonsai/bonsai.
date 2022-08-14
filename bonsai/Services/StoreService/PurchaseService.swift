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
   
   @Published var availablePackages: [Package] = []

   private var disposeBag = Set<AnyCancellable>()
   
   init() {
      getAvailablePackagesFromOfferings()
         .receive(on: RunLoop.main)
         .sink(receiveCompletion: { error in
            print("error \(error)")
         }, receiveValue: { pkg in
            self.availablePackages = pkg
         })
         .store(in: &disposeBag)
   }
   
   private func checkIfUserSubscriptionStatus() -> Bool {
      /*
       check this status to correctly show subscriptions screen for users
       */
      false
   }
   
   func buy(package: Package) {
      
         Purchases.shared.purchase(package: package) { storeTransaction, customerInfo, error, bool in
            if let error = error {
               
            }
            
            if customerInfo?.entitlements.all["Pro"]?.isActive == true {
               
            }
            if let storeTransaction = storeTransaction {
               
            }
         }
      
   }
   
   func restorePurchase() -> AnyPublisher<CustomerInfo, Error> {
      Future { promise in
         Purchases.shared.restorePurchases { customerInfo, error in
            if let error = error {
               promise(.failure(error))
            }
            if let customerInfo = customerInfo, error == nil {
               promise(.success(customerInfo))
            }
         }
      }.eraseToAnyPublisher()
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


