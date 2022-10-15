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
               TitleView(title: "Budget Name",
                         image:  BonsaiImage.textformatAlt,
                         text: $title)
               .cornerRadius(13)
               .focused($focusedField, equals: .title)
               .padding(.top, 8)
               .padding([.leading, .trailing], 16)
               
               AmountView(
                  amountTitle: "Budget Amount",
                  operation: .income,
                  currency: currency,
                  text: $amount
               )
               .frame(height: 44)
               .focused($focusedField,
                        equals: .amount)
               .cornerRadius(13)
               .padding(.top, 8)
               .padding([.leading, .trailing], 16)
               
               BudgetDateSelectorView()
                  .frame(height: 44)
                  .cornerRadius(13)
                  .padding(.top, 8)
                  .padding([.leading, .trailing], 16)
               Spacer()
               
               Button {
                
               } label: {
                  ZStack {
                     RoundedRectangle(cornerRadius: 13)
                        .frame(width: 192, height: 48)
                        .foregroundColor(BonsaiColor.mainPurple)
                     Text("Create")
                        .foregroundColor(BonsaiColor.card)
                        .font(.system(size: 17))
                        .bold()
                  }
               }
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
