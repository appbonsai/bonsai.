//
//  Currency.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11/9/22.
//

import Foundation
import OrderedCollections


// Thx: https://stackoverflow.com/a/65710111
public struct Currency {

   // Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties.
   static fileprivate var cache: [String: Currency] = { () -> [String: Currency] in
      var mapCurrencyCode2Symbols: [String: Set<String>] = [:]
      let currencyCodes = Set(Locale.commonISOCurrencyCodes)

      for localeId in Locale.availableIdentifiers {
         let locale = Locale(identifier: localeId)
         guard let currencyCode = locale.currencyCode,
               let currencySymbol = locale.currencySymbol else {
            continue
         }
         if currencyCode.contains(currencyCode) {
            mapCurrencyCode2Symbols[currencyCode, default: []].insert(currencySymbol)
         }
      }

      var mapCurrencyCode2Currency: [String: Currency] = [:]
      for (code, symbols) in mapCurrencyCode2Symbols {
         mapCurrencyCode2Currency[code] = Currency(code: code, symbols: Array(symbols))
      }
      return mapCurrencyCode2Currency
   }()

   /// Returns the currency code. For example USD or EUD
   let code: String

   /// Returns currency symbols. For example ["USD", "US$", "$"] for USD, ["RUB", "₽"] for RUB or ["₴", "UAH"] for UAH
   let symbols: [String]

   /// Returns shortest currency symbols. For example "$" for USD or "₽" for RUB
   var shortestSymbol: String? {
      symbols.min { $0.count < $1.count }
   }

   // for example 'US Dollar'
   var localizedName: String? {
      Locale.current.localizedString(forCurrencyCode: code)
   }

   /// Returns information about a currency by its code.
   static func find(_ code: String) -> Currency? {
      cache[code]
   }
}

public extension Currency {

   // Currency ready to use on UI
   struct Validated: Hashable, Comparable, Identifiable {

      let code: String
      let localizedName: String
      let symbol: String

      static var `default`: Validated {
         let fallback = Validated(code: "USD", localizedName: "US Dollar", symbol: "$")
         if let currency = Locale.current.currencyCode.flatMap(find(_:)) {
            return .init(currency: currency) ?? fallback
         }
         return fallback
      }

      static var current: Validated {
         get {
            if let code = userPreferenceCurrencyCode {
               return all.first { $0.code == code } ?? .default
            } else {
               return .default
            }
         }
         set {
            let context = DataController.sharedInstance.container.viewContext
            UserPreferences(context: context, currencyCode: newValue.code)
            try! context.save()
         }
      }

      static var all: OrderedSet<Validated> {
         var set = OrderedSet(
            Locale.commonISOCurrencyCodes.compactMap({ code -> Validated? in
               Currency.find(code).flatMap(Validated.init(currency:))
            })
         )
         set.sort()
         return set
      }

      static var userPreferenceCurrencyCode: String? {
         try? DataController.sharedInstance.container
            .viewContext
            .fetch(UserPreferences.fetchRequest())
            .first?
            .currencyCode
      }

      // MARK: - Identifiable

      public var id: String { code }

      // MARK: - Comparable

      public static func < (lhs: Validated, rhs: Validated) -> Bool {
         lhs.localizedName < rhs.localizedName
      }
   }
}

extension Currency.Validated {

   init?(currency: Currency) {
      guard let name = currency.localizedName,
            let symbol = currency.shortestSymbol else {
         return nil
      }
      self.code = currency.code
      self.localizedName = name.capitalizingFirstLetter()
      self.symbol = symbol
   }
}
