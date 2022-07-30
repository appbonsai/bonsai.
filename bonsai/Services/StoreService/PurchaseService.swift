//
//  PurchaseService.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import Foundation
import StoreKit
import CryptoKit

/*
 thanks to WWDC 2021 StoreKit2
 https://developer.apple.com/videos/play/wwdc2021/10114/
 */

final class StoreService: ObservableObject {
    
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

    @Published private(set) var autoRenewableSubscriptions: [Product]
    @Published private(set) var purchasedAutoRenewableSubscriptions: [Product] = []
    @Published private(set) var subscriptionGroupStatus: StoreKit.Product.SubscriptionInfo.RenewalState?

    private let productsId: [String: String]
    
    private var updateListeningTask: Task<Void, Error>? = nil
    
    init() {
        /*
         Path to Products with info.plist will be ready after configure on dev account
         */
        if let path = Bundle.main.path(forResource: "Products", ofType: "plist"),
           let plist = FileManager.default.contents(atPath: path) {
            productsId = (try? PropertyListSerialization.propertyList(from: plist, format: nil)) as? [String: String] ?? [:]
        } else {
            productsId = [:]
        }
        autoRenewableSubscriptions = []
        
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
            
            for product in storeProducts {
                switch product.type {
                case .autoRenewable:
                    newSubscriptions.append(product)
                default: print("unknown product")
                }
            }
            
            self.autoRenewableSubscriptions = sortByPrice(newSubscriptions)
            
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
        
        for await result in StoreKit.Transaction.currentEntitlements {
            do {
                let transaction = try checkVerify(result)
                
                switch transaction.productType {
                case .autoRenewable:
                    if let subscription = autoRenewableSubscriptions.first(where: { product in product.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                default: break
                }
                
            } catch {
                
            }
        }
        
        self.purchasedAutoRenewableSubscriptions = purchasedSubscriptions
        subscriptionGroupStatus = try? await autoRenewableSubscriptions.first?.subscription?.status.first?.state
    }
    
    private func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
    
    func isPurchased(_ product: Product) async throws -> Bool {
        guard let result = await StoreKit.Transaction.latest(for: product.id)
        else {
            return false
        }
        let transaction = try checkVerify(result)
        return transaction.revocationDate == nil && !transaction.isUpgraded
    }
    
    func tier(for productId: String) -> StoreService.SubscritionTier {
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
    
    private func isSignatureValid(transaction: StoreKit.Transaction) -> Bool {
        guard let localID = AppStore.deviceVerificationID?.uuidString.lowercased() else {
            return false
        }
        let combinedValue = transaction.deviceVerificationNonce.uuidString.lowercased() + localID
        let hashedValue = SHA384.hash(data: Data(combinedValue.utf8))
        if hashedValue == transaction.deviceVerification {
            //VALID!
            return true
        }
        return false
    }
}
