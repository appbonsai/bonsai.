//
//  Currency.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11/9/22.
//

import Foundation
import OrderedCollections

struct Currency: Hashable, Identifiable, Comparable, Equatable {

    // for example 'US Dollar'
    let localizedName: String

    // for example 'USD'
    let code: String

    // for example '$'
    let symbol: String

    init?(locale: Locale) {
        if let code = locale.currencyCode {
            self.code = code
            self.symbol = locale.currencySymbol ?? code
            self.localizedName = (locale.localizedString(forCurrencyCode: code) ?? code).capitalizingFirstLetter()
        } else {
            return nil
        }
    }

    init(code: String, locale: Locale) {
        self.code = code
        self.symbol = locale.currencySymbol ?? code
        self.localizedName = locale.localizedString(forCurrencyCode: code) ?? code
    }

    static var current: Currency {
        Currency(locale: Locale.current) ?? `default`
    }

    static var `default`: Currency {
        Currency(code: "USD", locale: Locale(identifier: "US"))
    }

    static var allAvailableCurrencies: OrderedSet<Currency> {
        var set = OrderedSet(Locale.availableIdentifiers.compactMap { id in
            Currency.init(locale: Locale(identifier: id))
        })
        set.sort()
        return set
    }

    // MARK: - Identifiable

    var id: String { code }

    // MARK: - Comparable

    static func < (lhs: Currency, rhs: Currency) -> Bool {
        lhs.localizedName < rhs.localizedName
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    // MARK: - Equatable

    static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.code == rhs.code
    }
}
