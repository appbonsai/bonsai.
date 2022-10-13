//
//  CreateEditBudget.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/10/2022.
//

import SwiftUI

struct CreateEditBudget: View {
   
   enum Kind: Equatable {
      case new
      case edit
   }
   private let kind: Kind
   @State private var currency: Currency.Validated
   @State private var amount: String
   @State private var title: String
   @FocusState private var focusedField: Field?
   enum Field {
      case amount
      case title
   }
   init() {
      self.kind = .new
      self._currency = .init(initialValue: .current)
      self._amount = .init(initialValue: "")
      self._title = .init(initialValue: "")
   }
   
   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            VStack {
               AmountView(
                  amountTitle: "Budget Amount",
                  operation: .income,
                  currency: currency,
                  text: $amount
               )
               .focused($focusedField,
                        equals: .amount)
               .cornerRadius(13)
               .padding([.top, .leading, .trailing], 12)
               TitleView(title: "Budget Name",
                         image:  BonsaiImage.textformatAlt,
                         text: $title)
               .cornerRadius(13)
               .focused($focusedField, equals: .title)
               .padding([.top, .leading, .trailing], 12)
               BudgetDateSelectorView()
                  .cornerRadius(13)
                  .padding([.top, .leading, .trailing], 12)
               Spacer()
            }
         }.navigationTitle(kind == .new ? "New Budget" : "Edit Budget")
      }
   }
}

struct CreateEditBudget_Previews: PreviewProvider {
   static var previews: some View {
      CreateEditBudget()
   }
}
