//
//  TabBar.swift
//  bonsai
//
//  Created by hoang on 11.12.2021.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var budgetTreeService: BudgetTreeService
    
    @State private var selection = 1
    
    private let tabBarImages: [Image] = [
        Image(systemName: "chart.bar.fill"),
        Image(systemName: "house.fill"),
        Image(Asset.treeFill.name)
    ]
    
    @FetchRequest(sortDescriptors: [])
    private var budgets: FetchedResults<Budget>
    private var budget: Budget? { budgets.first }
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
    private var transactions: FetchedResults<Transaction>
    
    func allTransactions() -> [Transaction] {
        transactions.map { $0 }
    }
    
    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 90) {
                ForEach(0..<3) { num in
                    tabBarImages[num]
                        .renderingMode(Image.TemplateRenderingMode.template)
                        .resizable()
                        .foregroundColor(
                            selection == num
                            ? BonsaiColor.mainPurple
                            : BonsaiColor.disabled
                        )
                        .frame(
                            width: selection == num ? 25 : 20,
                            height: selection == num ? 25 : 20
                        )
                        .animation(.easeInOut, value: selection)
                        .onTapGesture { selection = num }
                } // ForEach
            } // HStack
            GeometryReader { proxy in
                TabView(selection: $selection) {
                    ChartsView()
                        .tag(0)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                    HomeContainerView()
                        .tag(1)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                    BudgetDetails()
                        .tag(2)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                } // TabView
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background {
                    if let budget {
                        if let imageName =                             budgetTreeService.getTreeState(transactions: allTransactions(), budget: budget).imageName {
                            GifImage(
                                imageName
                            )
                            .offset(
                                x: {
                                    if selection == 0 {
                                        return proxy.size.width
                                    } else if selection == 1 {
                                        return proxy.size.width / 1.7
                                    } else {
                                        return 0
                                    }
                                }(),
                                y: 250
                            )
                        }
                    }
                }
            } // GeometryReader
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeOut, value: selection)
        } // VStack
        .padding(.top, 20)
        .background(BonsaiColor.back)
        .ignoresSafeArea(.keyboard)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
            .environmentObject(BudgetTreeService())
    }
}
