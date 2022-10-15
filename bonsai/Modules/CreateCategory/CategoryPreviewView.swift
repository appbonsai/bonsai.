//
//  CategoryPreviewView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 17.01.2022.
//

import SwiftUI

struct CategoryPreviewView: View {

   var gradient: LinearGradient
   var image: Image

   var body: some View {
      ZStack {
         gradient
            .frame(width: 100, height: 100, alignment: .center)
            .mask(Circle()
               .frame(width: 100, height: 100, alignment: .center)
               .foregroundColor(.white))
         image
            .resizable()
            .scaledToFit()
            .frame(width: 52, height: 52, alignment: .center)
            .foregroundColor(.white)
      }
   }
}

struct CategoryPreviewView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryPreviewView(
         gradient: Category.Color.g5.asGradient,
         image: Category.Icon.gameController.img
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
