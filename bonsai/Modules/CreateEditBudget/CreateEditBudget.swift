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
   @State private var periodDays: Int64
   @State private var createdDate: Date
   @FocusState private var focusedField: Field?
   @State var isPeriodDaysPresented: Bool = false
   @Binding var isCreateEditBudgetPresented: Bool
   @Environment(\.managedObjectContext) private var moc
   @EnvironmentObject var budgetService: BudgetService

   enum Field {
      case amount
      case title
   }
   init(isCreateEditBudgetPresented: Binding<Bool>, kind: Kind) {
      self.kind = kind
      self._currency = .init(initialValue: .current)
      self._amount = .init(initialValue: "")
      self._title = .init(initialValue: "")
      self._periodDays = .init(initialValue: 7)
      self._createdDate = .init(initialValue: .now)
      self._isCreateEditBudgetPresented = isCreateEditBudgetPresented
   }
   
   
   func amountView(text: Binding<String>) -> some View {
      AmountView(
         amountTitle: "Budget Amount",
         operation: .income,
         currency: currency,
         text: text
      )
      .contentShape(Rectangle())
      .frame(height: 44)
      .focused($focusedField,
               equals: .amount)
      .cornerRadius(13)
      .padding(.top, 8)
      .padding([.leading, .trailing], 16)
   }
   
   func titleView(text: Binding<String>) -> some View {
      TitleView(title: "Budget Name",
                image:  BonsaiImage.textformatAlt,
                text: text)
      .cornerRadius(13)
      .focused($focusedField, equals: .title)
      .padding(.top, 8)
      .padding([.leading, .trailing], 16)
      .contentShape(Rectangle())
   }
   
   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            VStack {
               if let budget = budgetService.getBudget() {
                  titleView(text: .constant(String(describing: budget.name)))
                  amountView(
                     text:.constant(String(describing: budget.amount))
                  )
               } else {
                  titleView(text: $title)
                  amountView(text: $amount)
               }
               
               BudgetDateSelectorView(selectedPeriod: .constant(String(describing: periodDays)))
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
                  do {
                     bonsai.Budget(
                        context: moc,
                        name: title,
                        totalAmount: .init(string: amount),
                        periodDays: periodDays,
                        createdDate: createdDate)
                     
                     try moc.save()
                     isCreateEditBudgetPresented = false
                  } catch (let e) {
                     assertionFailure(e.localizedDescription)
                  }
                  
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
         SelectBudgetPeriodView(isPresented: $isPeriodDaysPresented, completionDateSelected: { days in
            periodDays = .init(days)
         })
      }
   }
}

struct CreateEditBudget_Previews: PreviewProvider {
   static var previews: some View {
      CreateEditBudget(isCreateEditBudgetPresented: .constant(true), kind: .new)
   }
}
