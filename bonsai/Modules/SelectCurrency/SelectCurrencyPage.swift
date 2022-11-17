//
//  SelectCurrencyPage.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11/9/22.
//

import SwiftUI
import OrderedCollections

struct SelectCurrencyPage: View {

   @State var currencies: OrderedSet<Currency.Validated>
   @State var selectedCurrency: Currency.Validated?
   @Binding var isPresented: Bool

   init(isPresented: Binding<Bool>,
        currencies: OrderedSet<Currency.Validated>,
        selectedCurrency: Currency.Validated? = nil
   ) {
      self._isPresented = isPresented
      self._currencies = State(initialValue: currencies)
      self._selectedCurrency = State(initialValue: selectedCurrency)
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            VStack {
               ScrollViewReader { reader in
                  ScrollView(.vertical, showsIndicators: true) {
                     VStack(alignment: .center, spacing: 8) {
                        ForEach(currencies) { currency in
                           CurrencyCellView(
                              isSelected: currency == selectedCurrency,
                              currency: currency
                           )
                           .id(currency)
                           .padding(.horizontal, 16)
                           .onTapGesture {
                              selectedCurrency = currency
                              withAnimation {
                                 reader.scrollTo(currency, anchor: .center)
                              }
                           }
                        }
                     } // VStack
                     .onAppear {
                        if let selectedCurrency = selectedCurrency {
                           reader.scrollTo(selectedCurrency, anchor: .center)
                        }
                     }
                  } // ScrollView
               } // ScrollViewReader
               Button {
                  if let selectedCurrency = selectedCurrency {
                     Currency.Validated.current = selectedCurrency
                  }
                  isPresented = false
               } label: {
                  if let selectedCurrency = selectedCurrency {
                     Text("\(L.SelectCurrencyPage.choose) \(selectedCurrency.symbol)")
                  } else {
                     Text(L.SelectCurrencyPage.confirm)
                  }
               }
               .buttonStyle(PrimaryButtonStyle())
               .padding([.top, .bottom], 16)
               .disabled(selectedCurrency == nil)
            } // VStack
         } // ZStack
         .navigationTitle(L.SelectCurrencyPage.chooseDefaultCurrency)
         .navigationBarTitleDisplayMode(.inline)
      } // NavigationView
      .interactiveDismissDisabled(true)
   }
}

struct SelectCurrencyPage_Previews: PreviewProvider {
   static var previews: some View {
      SelectCurrencyPage(
         isPresented: .constant(true),
         currencies: Currency.Validated.all,
         selectedCurrency: nil
      )
      .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
      .previewDisplayName("iPhone 13")
   }
}
