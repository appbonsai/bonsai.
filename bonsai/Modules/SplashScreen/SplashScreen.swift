//
//  StartLaunchScreen.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/12/2022.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject private var dataController = DataController.sharedInstance
    @StateObject private var purchaseService = PurchaseService()
    @StateObject private var chartViewModel = ChartViewModel()
    @StateObject private var budgetTreeService = BudgetTreeService()
    @StateObject private var appStoreModel = AppstoreModel()

    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.persistentContainer, dataController.container)
                .environmentObject(purchaseService)
                .environmentObject(chartViewModel)
                .environmentObject(budgetTreeService)
                .environmentObject(appStoreModel)
        } else {
            ZStack {
                BonsaiColor.back
                VStack {
                    VStack {
                        Image(Asset.allSet1.name)
                            .font(.system(size: 80))
                            .foregroundColor(.red)
                        Text("Bonsai.")
                            .font(BonsaiFont.title_34)
                            .foregroundColor(.white.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.8)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }.ignoresSafeArea()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
