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
   
   func getAvailablePackagesFromOfferings() -> AnyPublisher<[Package], Never> {
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


