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
         .sink { pgk in
            self.availablePackages = pgk
         }
         .store(in: &disposeBag)
   }
   
   private func checkIfUserSubscriptionStatus() -> Bool {
      false
   }
   
   private func buy(product: StoreProduct) -> AnyPublisher<StoreTransaction, Never> {
      Future { promise in
         Purchases.shared.purchase(product: product) { storeTransaction, customerInfo, error, bool in
            if let storeTransaction = storeTransaction {
               promise(.success(storeTransaction))               
            }
         }
      }.eraseToAnyPublisher()
   }
   
   private func restorePurchase() -> AnyPublisher<CustomerInfo, Never> {
      Future { promise in
         Purchases.shared.restorePurchases { customerInfo, error in
            if let customerInfo = customerInfo, error == nil {
               promise(.success(customerInfo))
            }
         }
      }.eraseToAnyPublisher()
   }
   
   private func getAvailablePackagesFromOfferings() -> AnyPublisher<[Package], Never> {
      Future { promise in
         Purchases.shared.getOfferings { offerings, error in
            if let currentOffer = offerings?.current {
               let pakages = currentOffer.availablePackages
               promise(.success(pakages))
            }
         }
      }.eraseToAnyPublisher()
   
   }
}


