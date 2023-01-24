//
//  LanguageService.swift
//  bonsai
//
//  Created by antuan.khoanh on 08/12/2022.
//

import Foundation

// Thanks to abedalkareem omreyh

import Combine
import SwiftUI

public class LanguageSettings: ObservableObject {
    
    // MARK: - Properties
    ///
    /// Current app local. It's passed to the views as `environment` so they can use it to localise strings.
    /// Also, you can use it to localise the currency or to use it with a `NSDateFormatter`.
    ///
    public var local: Locale {
        Locale(identifier: selectedLanguage.rawValue)
    }
    
    ///
    /// The device preferred language.
    /// The device language is deffrent than the app language, it's the language the user is using for his device.
    /// To get the app language use `selectedLanguage`.
    ///
    public var deviceLanguage: Languages? {
        get {
            guard let deviceLanguage = Bundle.main.preferredLocalizations.first else {
                return nil
            }
            return Languages(rawValue: deviceLanguage)
        }
    }
    
    ///
    /// The direction of the language. You can expect one of these values, `rightToLeft` or `leftToRight`.
    ///
    public var layout: LayoutDirection {
        isRightToLeft ? .rightToLeft : .leftToRight
    }
    
    ///
    /// The diriction of the language as boolean.
    ///
    public var isRightToLeft: Bool {
        get {
            return isLanguageRightToLeft(language: selectedLanguage)
        }
    }
    
    ///
    /// A unique id used to refresh the view.
    ///
    var uuid: String {
        get {
            return UUID().uuidString
        }
    }
    
    // MARK: - State properties
    
    ///
    /// The current app selected language.
    /// Changing this value will refresh your views with the new selected language.
    /// The default language is the device language, so if the user device language is arabic, the app language will be arabic.
    ///
    @Published public var selectedLanguage: Languages = .deviceLanguage
    
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    
    @AppUserDefault(.selectedLanguage, defaultValue: nil)
    private var _language: String?
    
    // MARK: - init
    public init(defaultLanguage: Languages) {
        if _language == nil {
            _language = (defaultLanguage == .deviceLanguage ? deviceLanguage : defaultLanguage).map { $0.rawValue }
        }
        
        let lang = Languages(rawValue: _language ?? defaultLanguage.rawValue)
        selectedLanguage = lang ?? .en
        
        observeForSelectedLanguage()
    }
    
    // MARK: - Methods
    
    private func observeForSelectedLanguage() {
        $selectedLanguage
            .map({ $0.rawValue })
            .sink { [weak self] value in
                self?._language = value
            }
            .store(in: &bag)
    }
    
    private func isLanguageRightToLeft(language: Languages) -> Bool {
        return Locale.characterDirection(forLanguage: language.rawValue) == .rightToLeft
    }
}


public extension String {
    ///
    /// Returns localized key for the string.
    ///
    var localizedKey: LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}

public enum Languages: String {
    case en, vi, ru, uk, pl, zh
    
    case enGB = "en-GB"
    case enAU = "en-AU"
    case enCA = "en-CA"
    case enIN = "en-IN"
    case frCA = "fr-CA"
    case esMX = "es-MX"
    case ptBR = "pt-BR"
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    case zhHK = "zh-HK"
    case es419 = "es-419"
    case ptPT = "pt-PT"
    case deviceLanguage
    
    var fullnameLanguage: String {
        switch self {
        case .en: return "English"
        case .uk: return "Українська"
        case .ru: return "Русский"
        case .pl: return "Polski"
        case .vi: return "Tiếng việt"
        case .zhHans: return "Chinese"
        default: return "English"
        }
    }
}

import Foundation

@propertyWrapper
struct AppUserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: DefaultsKeys, defaultValue: T) {
        self.key = key.rawValue
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum DefaultsKeys: String {
    case selectedLanguage = "LanguageManagerSelectedLanguage"
}

public struct LanguageManagerView<Content: View>: View {
  
  // MARK: - Private properties
  
  private let content: Content
  @ObservedObject private var settings: LanguageSettings
  
  // MARK: init
  
  ///
  /// - Parameters:
  ///   - defaultLanguage: The default language when the app starts for the first time.
  ///
  public init(_ defaultLanguage: Languages, content: () -> Content) {
    self.content = content()
    self.settings = LanguageSettings(defaultLanguage: defaultLanguage)
  }
  
  // MARK: - body
  public var body: some View {
    content
      .environment(\.locale, settings.local)
      .environment(\.layoutDirection, settings.layout)
      .id(settings.uuid)
      .environmentObject(settings)
  }
}

// MARK: - Previews
struct LanguageManagerView_Previews: PreviewProvider {
  static var previews: some View {
    LanguageManagerView(.deviceLanguage) {
      Text("Hi")
    }
  }
}
