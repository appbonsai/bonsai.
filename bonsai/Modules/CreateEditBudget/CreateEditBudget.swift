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
    @State private var periodDays: Int = 7
    @State private var createdDate: Date = .now

    enum Field { case amount, title }
    @FocusState private var focusedField: Field?

    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(sortDescriptors: [])
    private var budgets: FetchedResults<Budget>
    private var budget: Budget? { budgets.first }

    func amountView(text: Binding<String>) -> some View {
        AmountView(
            amountTitle: L.Budget.amount,
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
        TitleView(title: L.Budget.name,
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

    @State var isDeleteConfirmationPresented = false

    func removeBudgetButton() -> some View {
        Button(L.Budget.Delete.button) {
            isDeleteConfirmationPresented = true
        }
        .foregroundColor(.red)
        .opacity(0.8)
        .confirmationDialog(
            L.deleteBudgetConfirmation,
            isPresented: $isDeleteConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button(L.Budget.Delete.confirmation, role: .destructive) {
                if let budget {
                    moc.delete(budget)
                    do {
                        try moc.save()
                    } catch (let e) {
                        assertionFailure(e.localizedDescription)
                    }
                    isCreateEditBudgetPresented = false
                }
            }
            Button(L.cancelTitle, role: .cancel) {
                isDeleteConfirmationPresented = false
            }
        }
    }

    var isDisabled: Bool {
        return $amount.wrappedValue == ""
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

                    if kind == .edit {
                        removeBudgetButton()
                            .padding(20)
                    }

                    Spacer()

                    Button {
                        if $amount.wrappedValue != "" {
                            if let budget {
                                budget.amount = NSDecimalNumber(string: amount)
                                budget.periodDays = Int64(periodDays)
                                budget.name = title
                            } else {
                                bonsai.Budget(
                                    context: moc,
                                    name: title,
                                    totalAmount: .init(string: amount),
                                    periodDays: Int64(periodDays),
                                    createdDate: createdDate
                                )
                            }
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

                            Text(kind == . new ? L.Budget.create : L.Budget.save)
                                .foregroundColor(BonsaiColor.card)
                                .font(.system(size: 17))
                                .bold()
                        }
                    }
                    .opacity(isDisabled ? 0.5 : 1)
                    .disabled(isDisabled)
                } // VStack
                .padding(.top, 20)
            }
            .navigationTitle(kind == .new ? L.Budget.new : L.Budget.edit)
        }
        .popover(isPresented: $isPeriodDaysPresented) {
            SelectBudgetPeriodView(
                isPresented: $isPeriodDaysPresented,
                period: $periodDays
            )
        }
        .onAppear {
            if let budget {
                periodDays = Int(budget.periodDays)
                title = budget.name
                amount = String(budget.amount.intValue)
            }
        }
    }
}

struct CreateEditBudget_Previews: PreviewProvider {
    static var previews: some View {
        CreateEditBudget(kind: .new, isCreateEditBudgetPresented: .constant(true))
    }
}
