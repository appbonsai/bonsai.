//
//  CreateCategoryView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 18.12.2021.
//

import SwiftUI

struct CreateCategoryView: View {

   @State private var title: String = ""
   private let characterLimit = 16
   
   init() {
       UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
       UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
                .ignoresSafeArea()
            VStack {
               TextField("", text: $title)
                  .onReceive(title.publisher.collect(), perform: {
                     if $0.count > characterLimit {
                        title = String($0.prefix(characterLimit))
                     }
                  })
                  .frame(height: 50, alignment: .center)
                  .padding([.leading], 16)
                  .font(BonsaiFont.body_17)
                  .modifier(
                     PlaceholderStyle(
                        showPlaceHolder: title.isEmpty,
                        placeholder: "Title (maximum of 16 symbols)",
                        placeholderColor: BonsaiColor.prompt,
                        contentColor: BonsaiColor.purple3,
                        placeholderPadding: 16
                     )
                  )
                  .background(BonsaiColor.card)
                  .cornerRadius(13)
                  .padding([.leading, .trailing], 16)

                  Button("Create") {
                     print("create")
                  }
                  .buttonStyle(PrimaryButtonStyle())
            }
            .navigationTitle("New category")
         }
      }
   }
}

struct CreateCategoryView_Previews: PreviewProvider {
   static var previews: some View {
      CreateCategoryView()
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
