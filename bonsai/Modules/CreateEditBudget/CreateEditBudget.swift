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
   @State var isPeriodDaysPresented: Bool = false
   @Binding var isCreateEditBudgetPresented: Bool

   enum Field {
      case amount
      case title
   }
   init(isCreateEditBudgetPresented: Binding<Bool>) {
      self.kind = .new
      self._currency = .init(initialValue: .current)
      self._amount = .init(initialValue: "")
      self._title = .init(initialValue: "")
      self._isCreateEditBudgetPresented = isCreateEditBudgetPresented
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
               .contentShape(Rectangle())
               
               AmountView(
                  amountTitle: "Budget Amount",
                  operation: .income,
                  currency: currency,
                  text: $amount
               )
               .contentShape(Rectangle())
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
                  .onTapGesture {
                     isPeriodDaysPresented = true
                  }
               Spacer()
               
               let isDisabled = $amount.wrappedValue.isEmpty && $title.wrappedValue.isEmpty
               Button {
                  isCreateEditBudgetPresented = false
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
               .opacity(isDisabled ? 0.5 : 1)
               .disabled(isDisabled)
            }
         }.navigationTitle(kind == .new ? "New Budget" : "Edit Budget")
      }
      .popover(isPresented: $isPeriodDaysPresented) {
         SelectBudgetPeriodView(isPresented: $isPeriodDaysPresented)
      }
   }
}

struct CreateEditBudget_Previews: PreviewProvider {
   static var previews: some View {
      CreateEditBudget(isCreateEditBudgetPresented: .constant(true))
   }
}
