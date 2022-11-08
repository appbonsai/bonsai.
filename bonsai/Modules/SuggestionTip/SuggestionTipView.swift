//
//  SuggestionTipView.swift
//  bonsai
//
//  Created by antuan.khoanh on 07/11/2022.
//

import SwiftUI

struct SuggestionTipView: View {
   
   @Binding var isSuggestionPresented: Bool
   
   init(isSuggestionPresented: Binding<Bool>) {
      self._isSuggestionPresented = isSuggestionPresented
      UINavigationBar.changeAppearance(clear: true)
   }
   
   var body: some View {
      NavigationView {
         ScrollView(.vertical, showsIndicators: false) {
            Text("Tree progress")
               .font(BonsaiFont.title_28)
               .foregroundColor(BonsaiColor.text)
               .padding(.top, 12)
            VStack(spacing: 0){
               ForEach(arr, id: \.self) { el in
                  ContentCellView(isLast: false, image: el.image, color: el.color, text: el.text
                  )
               }
            }
         }
         .background(BonsaiColor.back)
         .ignoresSafeArea()
      }
   }
}

var arr: [Suggest] = [
   .init(image: "bonsai_die_png", color: BonsaiColor.separator, text: "Dying tree, bad things happens, but you have a chance to recovery!"),
   .init(image: "bonsai_orange_png", color: BonsaiColor.orange, text: "Orange tree, something goes wrong, try to reduce your daily expenses!"),
   .init(image: "bonsai_purple_png", color: BonsaiColor.mainPurple, text: "Purple tree, try to use money more wisly and keep going!"),
   .init(image: "bonsai_green_png", color: BonsaiColor.green, text: "Excellent tree, keep doing and your tree would be fantastic!"),
]

struct Suggest: Hashable {
   let image: String
   let color: Color
   let text: String
}

struct ContentCellView: View {
   var isLast: Bool = false
   var image: String = ""
   var color: Color = BonsaiColor.green
   var text: String
   var body: some View {
      ZStack {
         HStack {
            VStack(alignment: .center) {
               if !isLast {
                  Rectangle()
                     .fill(color)
                     .cornerRadius(13)
                     .frame(width: 5, height: 120, alignment: .center)
               }
               Image(systemName: "message.circle")
                  .frame(width: 30)
            }
            
            VStack(alignment: .leading, spacing: 0) {
               HStack {
                  GifImage(image)
                     .frame(width: 150, height: 150)
                  Spacer()
                  Text(text)
                     .foregroundColor(.white)
                     .font(BonsaiFont.body_17)
                     .padding(.trailing, 10)
               }
            }
         }
      }
      .background(BonsaiColor.back)
      .ignoresSafeArea()
   }
}

struct SuggestionTipView_Previews: PreviewProvider {
   static var previews: some View {
      SuggestionTipView(isSuggestionPresented: .constant(false))
   }
}
