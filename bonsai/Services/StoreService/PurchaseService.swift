//
//  PurchaseService.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import Foundation
import StoreKit

protocol StoreServiceProtocol {
    
}

final class StoreService: ObservableObject, StoreServiceProtocol {
    
    public enum SubscritionTier: Int, Comparable {
        
        public static func < (lhs: StoreService.SubscritionTier, rhs: StoreService.SubscritionTier) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
        case none = 0
        case standard = 1
        case premium = 2
        case pro = 3
    }
    
    public enum StoreError: Error {
        case failedVerification
    }

    @Published private(set) var newSubscriptions: [Product]
    @Published private(set) var newNonRenewables: [Product]
    
    private let productsId: [String: String] = [:]
    
    init() {
        newSubscriptions = []
        newNonRenewables = []
        
        Task {
            await requestProducts()
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: Set(productsId.keys))
            var newSubscriptions: [Product] = []
            var newNonRenewables: [Product] = []
            
            for product in storeProducts {
                switch product.type {
                case .autoRenewable:
                    newSubscriptions.append(product)
                case .nonRenewable:
                    newNonRenewables.append(product)
                default: print("unknown product")
                }
            }
            
            self.newSubscriptions = sortByPrice(newSubscriptions)
            self.newNonRenewables = sortByPrice(newNonRenewables)
        } catch let error {
            print("Can not get product \(error.localizedDescription)")
        }
    }
    
    func purchase(_ product: Product) async throws -> StoreKit.Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            let transaction = try checkVerify(verification)
            await updateCustomerProductStatus()
            await transaction.finish()
            return transaction
        case .pending: return nil
        case .userCancelled: return nil
        default: return nil
        }
    }
    
    private func checkVerify<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, _):
            throw StoreService.StoreError.failedVerification
        case .verified(let verified):
            return verified
        }
    }
    
    @MainActor
    private func updateCustomerProductStatus() async {
        for await result in StoreKit.Transaction.currentEntitlements {
            
        }
    }
    
    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
    
}
