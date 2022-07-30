//
//  PurchaseService.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import Foundation
import StoreKit

/*
 thanks to WWDC 2021 StoreKit2
 https://developer.apple.com/videos/play/wwdc2021/10114/
 */

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
    @Published private(set) var purchasedSubscriptions: [Product]
    @Published private(set) var purchasedNonRenewableSubscriptions: [Product]
    @Published private(set) var subscriptionGroupStatus: StoreKit.Product.SubscriptionInfo.RenewalState?

    private let productsId: [String: String] = [:]
    
    private var updateListeningTask: Task<Void, Error>? = nil
    
    init() {
        newSubscriptions = []
        newNonRenewables = []
        purchasedSubscriptions = []
        purchasedNonRenewableSubscriptions = []
        
        updateListeningTask = listenForTransactions()
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListeningTask?.cancel()
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        Task.detached { [self] in
            for await result in StoreKit.Transaction.updates {
                do {
                    let transation = try checkVerify(result)
                    await updateCustomerProductStatus()
                    await transation.finish()
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    private func requestProducts() async {
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
        var purchasedSubscriptions: [Product] = []
        var purchasedNonRenewableSubscriptions: [Product] = []
        
        for await result in StoreKit.Transaction.currentEntitlements {
            do {
                let transaction = try checkVerify(result)
                
                switch transaction.productType {
                case .autoRenewable:
                    if let subscription = newSubscriptions.first(where: { product in product.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                case .nonRenewable:
                    if let nonRenewable = newNonRenewables.first(where: { product in product.id == transaction.productID }), transaction.productID == "nonRenewing.standard" {
                        
                        let currentDate = Date()
                        let expirationDate = Calendar(identifier: .gregorian)
                            .date(byAdding: DateComponents(year: 1), to: transaction.purchaseDate)!
                        if currentDate < expirationDate {
                            purchasedNonRenewableSubscriptions.append(nonRenewable)
                        }
                    }
                default: break
                }
                
            } catch {
                
            }
        }
        
        self.purchasedSubscriptions = purchasedSubscriptions
        self.purchasedNonRenewableSubscriptions = purchasedNonRenewableSubscriptions
        subscriptionGroupStatus = try? await newSubscriptions.first?.subscription?.status.first?.state
    }
    
    private func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
    
    private func isPurchased(_ product: Product) async throws -> Bool {
        switch product.type {
        case .autoRenewable:
            return purchasedSubscriptions.contains(product)
        case .nonRenewable:
            return purchasedNonRenewableSubscriptions.contains(product)
        default:
            return false
        }
    }
    
    private func tier(for productId: String) -> StoreService.SubscritionTier {
        switch productId {
        case "subscription.standard":
            return .standard
        case "subscription.premium":
            return .premium
        case "subscription.pro":
            return .pro
        default:
            return .none
        }
    }
    
}
