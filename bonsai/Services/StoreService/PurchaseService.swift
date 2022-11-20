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
import StoreKit

final class PurchaseService: ObservableObject {
    
    private struct Pro {
        static var typeName: String {
            return String(describing: Self.self)
        }
    }
    
    @Published var packages: [Package] = []
    @Published var isSubscriptionActive = false
    @Published var isShownAllSet = false
    
    @Published var expirationDate: String = ""
    @Published var purchaseDate: String = ""
    
    
    private var disposeBag = Set<AnyCancellable>()
    
    private struct UKR {
        static var typeName: String {
            return String(describing: Self.self)
        }
    }
    
    var isUKRStoreFront: Bool {
        storefront?.countryCode == UKR.typeName
    }
    
    private let storefront = SKPaymentQueue.default().storefront
    
    init() {
        checkIfUserSubscriptionStatus()
        getAvailablePackagesFromOfferings()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { error in
                print("error \(error)")
            }, receiveValue: { [weak self] pkg in
                self?.packages = pkg
            })
            .store(in: &disposeBag)
    }
    
    func checkIfUserSubscriptionStatus() {
        Purchases.shared.getCustomerInfo { [weak self] customerInfo, error in
            let isActive = customerInfo?.entitlements.all[Pro.typeName]?.isActive == true
            self?.purchaseDate = customerInfo?.entitlements.all[Pro.typeName]?.latestPurchaseDate?.dateString() ?? ""
            self?.expirationDate = customerInfo?.entitlements.all[Pro.typeName]?.expirationDate?.dateString() ?? ""
            
            if let storefront = self?.storefront {
                if storefront.countryCode == UKR.typeName {
                    self?.isSubscriptionActive = true
                } else {
                    self?.isSubscriptionActive = isActive
                }
            } else {
                self?.isSubscriptionActive = isActive
            }
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
                    if allEntitlements.isActive {
                        self.isShownAllSet = true
                    }
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
                if allEntitlements.isActive {
                    self.isShownAllSet = true
                }
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

