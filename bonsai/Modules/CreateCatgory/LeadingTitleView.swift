//
//  LeadingTitleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 17.01.2022.
//

import SwiftUI

struct LeadingTitleView: View {
   let text: String

   var body: some View {
      HStack {
         Text(text)
            .foregroundColor(.white)
            .font(BonsaiFont.title_20)
         Spacer()
      }
   }
}

struct LeadingTitleView_Previews: PreviewProvider {
   static var previews: some View {
      LeadingTitleView(text: "Test")
   }
}
