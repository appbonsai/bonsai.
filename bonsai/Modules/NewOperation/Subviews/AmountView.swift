//
//  AmountView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11.12.2021.
//

import SwiftUI

struct AmountView: View {

   let operation: Operation
   @Binding var text: String
   private let characterLimit = 16

   var body: some View {
      HStack(spacing: 8) {
         Image(uiImage: BonsaiImage.amount)
            .foregroundColor(operation.viewModel.color)
            .padding([.leading, .top, .bottom], 16)
         TextField("", text: $text)
            .font(BonsaiFont.body_17)
            .foregroundColor(operation.viewModel.color)
            .placeholder(
               Text("Amount")
                  .foregroundColor(BonsaiColor.prompt),
               show: text.isEmpty
            )
            .modifier(
               CharacterLimit(
                  text: $text,
                  limit: characterLimit
               )
            )
      }
      .background(BonsaiColor.card)
   }
}

struct AmountView_Previews: PreviewProvider {
   static var previews: some View {
      AmountView(operation: .expense, text: .constant(""))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}

extension AmountView {
   typealias Operation = NewOperationView.OperationType
}
