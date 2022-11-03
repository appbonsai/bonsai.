//
//  CreateEditBudget.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/10/2022.
//

import SwiftUI

struct CreateEditBudget: View {

   enum Kind: Equatable { case new, edit }
   let kind: Kind

   @State var isPeriodDaysPresented: Bool = false
   @Binding var isCreateEditBudgetPresented: Bool

   @State private var currency: Currency.Validated = .current
   @State private var amount: String = ""
   @State private var title: String = ""
   @State private var periodDays: Int64 = 7
   @State private var createdDate: Date = .now

   enum Field { case amount, title }
   @FocusState private var focusedField: Field?

   @Environment(\.managedObjectContext) private var moc

   @EnvironmentObject var budgetService: BudgetService

   @FetchRequest(sortDescriptors: [])
   private var budgets: FetchedResults<Budget>
   private var budget: Budget? { budgets.first }

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

   func periodView(text: String) -> some View {
      BudgetDateSelectorView(selectedPeriod: text)
         .frame(height: 44)
         .cornerRadius(13)
         .padding(.top, 8)
         .padding([.leading, .trailing], 16)
         .onTapGesture {
            isPeriodDaysPresented = true
         }
   }

   var isDisabled: Bool {
      if budget == nil {
         return $amount.wrappedValue.isEmpty && $title.wrappedValue.isEmpty
      } else {
         return kind != .edit
      }
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            VStack {
               titleView(text: $title)
               amountView(text: $amount)
               periodView(text: String(periodDays))
               
               Spacer()

               Button {
                  if let budget {
                     budget.amount = NSDecimalNumber(string: amount)
                     budget.periodDays = periodDays
                     budget.name = title
                  } else {
                     bonsai.Budget(
                        context: moc,
                        name: title,
                        totalAmount: .init(string: amount),
                        periodDays: periodDays,
                        createdDate: createdDate
                     )
                  }
                  do {
                     try moc.save()
                  } catch (let e) {
                     assertionFailure(e.localizedDescription)
                  }
                  isCreateEditBudgetPresented = false

               } label: {
                  ZStack {
                     RoundedRectangle(cornerRadius: 13)
                        .frame(width: 192, height: 48)
                        .foregroundColor(BonsaiColor.mainPurple)

                     Text(kind == . new ? "Create" : "Edit")
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
         SelectBudgetPeriodView(
            isPresented: $isPeriodDaysPresented,
            completionDateSelected: { days in
               periodDays = .init(days)
               do {
                  budget?.periodDays = .init(days)
                  try moc.save()
               } catch (let e) {
                  assertionFailure(e.localizedDescription)
               }
            }
         )
      }
      .onAppear {
         if let budget {
            periodDays = budget.periodDays
            title = budget.name
            amount = String(budget.amount.intValue)
         }
      }
   }
}

struct CreateEditBudget_Previews: PreviewProvider {
   static var previews: some View {
      CreateEditBudget(kind: .new, isCreateEditBudgetPresented: .constant(true))
         .environmentObject(BudgetService(
            budgetRepository: BudgetRepository(),
            budgetCalculations: BudgetCalculations()
         ))
   }
}
