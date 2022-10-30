//
//  TabBar.swift
//  bonsai
//
//  Created by hoang on 11.12.2021.
//

import SwiftUI

struct TabBar: View {
   static var topPadding: CGFloat = 57
   
   @State private var selection = 1
   
   private let tabBarImages: [Image] = [
      Image(systemName: "chart.bar.fill"),
      Image(systemName: "house.fill"),
      Image("tree.fill")
   ]
   
   var body: some View {
      VStack {
         HStack {
            ForEach(0..<3) { num in
               Label {
               } icon: {
                  Spacer()
                  tabBarImages[num]
                     .renderingMode(Image.TemplateRenderingMode.template)
                     .resizable()
                     .foregroundColor(selection == num ? BonsaiColor.mainPurple : BonsaiColor.disabled)
                     .frame(
                        width: selection == num ? 25 : 20,
                        height: selection == num ? 25 : 20
                     )
                     .animation(.easeInOut)
                  Spacer()
               }
               .onTapGesture {
                  selection = num
               }
            }
         }

         TabView(selection: $selection) {
            ChartsView()
               .tag(0)
            HomeContainerView()
               .tag(1)
            BudgetDetails()
               .tag(2)
         }
         .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
         .background {
            GifImage("bonsai4_png")
               .offset(
                  x: {
                     if selection == 0 {
                        return 500
                     } else if selection == 1 {
                        return 200
                     } else {
                        return 0
                     }
                  }(),
                  y: 250
               )
         }
         .animation(.easeOut, value: selection)
      }
      .padding(.top, TabBar.topPadding)
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
