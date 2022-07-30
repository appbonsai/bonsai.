//
//  SwiftUIView.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import SwiftUI
import StoreKit

/*
 this view only for test to show autoRenewable/nonRenewable subscriptions
 */

struct OnboardingMockView: View {
    
    @EnvironmentObject var storeService: StoreService
    @State var isPurchased: Bool = false
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    private func buy() async {
        do {
            if try await storeService.purchase(product) != nil {
                withAnimation {
                    isPurchased = true
                }
            }
        } catch { }
    }
}
