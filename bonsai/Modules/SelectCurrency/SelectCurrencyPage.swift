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
            currencies: Currency.Validated.all,
            selectedCurrency: nil,
            isPresented: .constant(true)
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("iPhone 13")
    }
}
