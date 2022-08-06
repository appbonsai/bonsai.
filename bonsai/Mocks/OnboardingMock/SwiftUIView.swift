//
//  SwiftUIView.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import SwiftUI
import RevenueCat
/*
 this view only for test to show autoRenewable/nonRenewable subscriptions
 */

struct OnboardingMockView: View {
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(
            with:
                Configuration.builder(withAPIKey: "some API")
                .with(usesStoreKit2IfAvailable: true)
                .build()
        )
        Purchases.shared.delegate = PurchasesDelegateHandler.shared
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                do {
                    UserViewModel.shared.offerings = try await Purchases.shared.offerings()
                } catch let error {
                    print("catch offer error: \(error.localizedDescription)")
                }
            }
    }
    
}

private class PurchasesDelegateHandler: NSObject, ObservableObject {
    static let shared = PurchasesDelegateHandler()
}

extension PurchasesDelegateHandler: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        UserViewModel.shared.customerInfo = customerInfo
    }
}

class UserViewModel: ObservableObject {
    static let shared = UserViewModel()
    
    @Published var customerInfo: CustomerInfo? {
        didSet {
            subscriptionsActive = customerInfo?.entitlements["some entitlementsID"]?.isActive == true
        }
    }
    @Published var offerings: Offerings? = nil
    @Published var subscriptionsActive: Bool = false
    
}
