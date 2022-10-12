//
//  CategoryPreviewView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 17.01.2022.
//

import SwiftUI

struct CategoryPreviewView: View {

   let gradient: LinearGradient
   let image: Category.Image

   var body: some View {
      ZStack {
         gradient
            .frame(width: 100, height: 100, alignment: .center)
            .mask(Circle()
               .frame(width: 100, height: 100, alignment: .center)
               .foregroundColor(.white))
         if case let .emoji(text) = image {
            Text(text)
               .font(.system(size: 44))
         }
         if case let .icon(img) = image {
            img.img
               .resizable()
               .scaledToFit()
               .frame(width: 52, height: 52, alignment: .center)
               .foregroundColor(.white)
         }
      }
   }
}

struct CategoryPreviewView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryPreviewView(
         gradient: Category.Color.g5.asGradient,
         image: .icon(.gameController)
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
