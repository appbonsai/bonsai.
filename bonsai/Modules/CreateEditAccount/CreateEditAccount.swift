//
//  CreateEditAccount.swift
//  bonsai
//
//  Created by antuan.khoanh on 05/02/2023.
//

import SwiftUI

struct CreateEditAccount: View {

    enum Kind: Equatable { case new, edit }
    let kind: Kind
    @Environment(\.dismiss) var dismiss

    @State private var currency: Currency.Validated = .current
    @State private var title: String = ""
    @State private var periodDays: Int = 7
    @State private var createdDate: Date = .now

    enum Field { case title }
    @FocusState private var focusedField: Field?

    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(sortDescriptors: [])
    private var accounts: FetchedResults<Account>
    private var account: Account? { accounts.first }
    
    var completion: ((Account?) -> Void)? = nil

    func titleView(text: Binding<String>) -> some View {
        TitleView(title: "account.name",
                  image:  BonsaiImage.textformatAlt,
                  text: text)
        .cornerRadius(13)
        .focused($focusedField, equals: .title)
        .padding(.top, 8)
        .padding([.leading, .trailing], 16)
        .contentShape(Rectangle())
    }

    @State var isDeleteConfirmationPresented = false

    func removeAccountButton() -> some View {
        Button(LocalizedStringKey("account.delete.button")) {
            isDeleteConfirmationPresented = true
        }
        .foregroundColor(.red)
        .opacity(0.8)
        .confirmationDialog(
            LocalizedStringKey("delete_Account_Confirmation"),
            isPresented: $isDeleteConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button(LocalizedStringKey("account.delete.confirmation"), role: .destructive) {
                if let account {
                    moc.delete(account)
                    do {
                        try moc.save()
                    } catch (let e) {
                        assertionFailure(e.localizedDescription)
                    }
                    dismiss()
                }
            }
            Button(LocalizedStringKey("Cancel_title"), role: .cancel) {
                isDeleteConfirmationPresented = false
            }
        }
    }

    var isDisabled: Bool {
        return $title.wrappedValue == ""
    }

    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()
                VStack {
                    titleView(text: $title)
                    
                    if kind == .edit {
                        removeAccountButton()
                            .padding(20)
                    }

                    Spacer()

                    Button {
                        if $title.wrappedValue != "" {
                            if let account, kind == .edit {
                                account.title = title
                            } else {
                                let newAccount = bonsai.Account(
                                    context: moc,
                                    title: title
                                )
                                completion?(newAccount)
                            }
                        }
                        do {
                            try moc.save()
                        } catch (let e) {
                            assertionFailure(e.localizedDescription)
                        }
                        dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 13)
                                .frame(width: 192, height: 48)
                                .foregroundColor(BonsaiColor.mainPurple)

                            Text(LocalizedStringKey(kind == . new ? "account.create" : "account.save"))
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
            .navigationTitle(LocalizedStringKey(kind == .new ? "account.new" : "account.edit"))
            .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                  Button(action: {
                      completion?(nil)
                      dismiss()
                  }) {
                     Text(LocalizedStringKey("Cancel_title"))
                        .foregroundColor(BonsaiColor.secondary)
                  }
               }
            }
        }
        .onAppear {
            if let account, kind == .edit {
                title = account.title
            }
        }
   
    }
}

struct CreateEditAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateEditAccount(kind: .new)
    }
}
