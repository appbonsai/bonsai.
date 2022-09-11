//
//  SelectCurrencyPage.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11/9/22.
//

import SwiftUI
import OrderedCollections

struct SelectCurrencyPage: View {

   @State var currencies: OrderedSet<Currency>
   @State var selectedCurrency: Currency?
   @Binding var isPresented: Bool

   init(isPresented: Binding<Bool>, currencies: OrderedSet<Currency>, selectedCurrency: Currency? = nil) {
      self._isPresented = isPresented
      self._currencies = State(initialValue: currencies)
      self._selectedCurrency = State(initialValue: selectedCurrency)
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.isTranslucent = false
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
                     VStack(spacing: 8) {
                        ForEach(currencies) { currency in
                           CurrencyCellView(
                              isSelected: currency == selectedCurrency,
                              currency: currency
                           )
                           .id(currency)
                           .onTapGesture {
                              selectedCurrency = currency
                              withAnimation {
                                 reader.scrollTo(currency, anchor: .center)
                              }
                           }
                        }
                     } // VStack
                     .padding([.leading, .trailing], 16)
                     .onAppear {
                        if let selectedCurrency = selectedCurrency {
                           reader.scrollTo(selectedCurrency, anchor: .center)
                        }
                     }
                  } // ScrollView
               } // ScrollViewReader
               Button {
                  if let selectedCurrency = selectedCurrency {
                     Currency.current = selectedCurrency
                  }
                  isPresented = false
               } label: {
                  if let selectedCurrency = selectedCurrency {
                     Text("\(L.SelectCurrencyPage.Choose) \(selectedCurrency.symbol)")
                  } else {
                     Text(L.SelectCurrencyPage.Confirm)
                  }
               }
               .buttonStyle(PrimaryButtonStyle())
               .padding([.top], 16)
               .disabled(selectedCurrency == nil)
            } // VStack
         } // ZStack
         .navigationTitle(L.SelectCurrencyPage.Choose_default_currency)
         .navigationBarTitleDisplayMode(.inline)
      } // NavigationView
   }
}

struct SelectCurrencyPage_Previews: PreviewProvider {
   static var previews: some View {
      SelectCurrencyPage(
         isPresented: .constant(true),
         currencies: Currency.allAvailableCurrencies,
         selectedCurrency: nil
      )
      .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
      .previewDisplayName("iPhone 13")
   }
}
