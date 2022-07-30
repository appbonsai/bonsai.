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
    
    func purchase(_ product: Product) async throws -> Transaction? {
        return nil
    }
    
    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
    
}
