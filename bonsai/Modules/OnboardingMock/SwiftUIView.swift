//
//  SwiftUIView.swift
//  bonsai
//
//  Created by antuan.khoanh on 30/07/2022.
//

import SwiftUI

/*
 this view only for test to show autoRenewable/nonRenewable subscriptions
 */

struct OnboardingMockView: View {
    
    @StateObject var store = StoreService()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OnboardingMockView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingMockView()
    }
}
