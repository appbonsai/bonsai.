//
//  Currency.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11/9/22.
//

import Foundation
import OrderedCollections

public struct Currency: Hashable, Identifiable, Comparable, Equatable {

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
      get {
         var defaultCurrency: Currency {
            Currency(locale: Locale.current) ?? `default`
         }
         if let userPreferenceCurrencyCode = userPreferenceCurrencyCode {
            return .allAvailableCurrencies.first(where: { $0.code == userPreferenceCurrencyCode }) ?? defaultCurrency
         } else {
            return defaultCurrency
         }
      }
      set {
         userPreferenceCurrencyCode = newValue.code
      }
   }

   @UserDefault("Currency.userPreferenceCurrencyCode")
   static var userPreferenceCurrencyCode: String?

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

   public var id: String { code }

   // MARK: - Comparable

   public static func < (lhs: Currency, rhs: Currency) -> Bool {
      lhs.localizedName < rhs.localizedName
   }

   // MARK: - Hashable

   public func hash(into hasher: inout Hasher) {
      hasher.combine(code)
   }

   // MARK: - Equatable

   public static func == (lhs: Currency, rhs: Currency) -> Bool {
      lhs.code == rhs.code
   }
}
