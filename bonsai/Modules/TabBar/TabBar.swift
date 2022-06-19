//
//  TabBar.swift
//  bonsai
//
//  Created by hoang on 11.12.2021.
//

import SwiftUI

struct TabBar: View {

   @State private var selection = 1

   private let tabBarImages: [String] = [Asset.settingDisabled.name,
                                         Asset.homeDisabled.name,
                                         Asset.chartsDisabled.name]

   var body: some View {
      VStack {
         HStack {
            ForEach(0..<3) { num in
               Label {
               } icon: {
                  Spacer()
                  Image(tabBarImages[num])
                     .renderingMode(Image.TemplateRenderingMode.template)
                     .resizable()
                     .foregroundColor(selection == num ? BonsaiColor.mainPurple : BonsaiColor.disabled)
                     .frame(
                        width: selection == num ? 25 : 20,
                        height: selection == num ? 25 : 20)
                     .animation(.easeInOut)
                  Spacer()
               }
               .onTapGesture {
                  selection = num
               }
            }
         }
         TabView(selection: $selection) {
            BudgetDetails(mainContext: MockDataTransaction.viewContext)
               .tag(0)
            HomeContainerView()
               .tag(1)
            BudgetDetails(mainContext: MockDataTransaction.viewContext)
               .tag(2)
         }
         .animation(.easeInOut)
         .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      }
      .padding(.top, 37 + 20)
      .background(BonsaiColor.back)
      .ignoresSafeArea()
   }

}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}

