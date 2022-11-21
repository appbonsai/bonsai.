// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Congratulations! Now you have full access to Bonsai premium function.
  internal static let allSetText = L10n.tr("Localizable", "AllSet_text", fallback: "Congratulations! Now you have full access to Bonsai premium function.")
  /// All set
  internal static let allSetTitle = L10n.tr("Localizable", "AllSet_title", fallback: "All set")
  /// Back
  internal static let backTitle = L10n.tr("Localizable", "Back_title", fallback: "Back")
  /// Best value
  internal static let bestValue = L10n.tr("Localizable", "Best_value", fallback: "Best value")
  /// Hey, you are doing well!
  internal static let budgetGreeting = L10n.tr("Localizable", "Budget_greeting", fallback: "Hey, you are doing well!")
  /// Budget
  internal static let budgetTitle = L10n.tr("Localizable", "Budget_title", fallback: "Budget")
  /// Budget until
  internal static let budgetUntilTitle = L10n.tr("Localizable", "Budget_until_title", fallback: "Budget until")
  /// Cancel
  internal static let cancelTitle = L10n.tr("Localizable", "Cancel_title", fallback: "Cancel")
  /// Charts
  internal static let chartsTitle = L10n.tr("Localizable", "Charts_title", fallback: "Charts")
  /// Custom
  internal static let chooseBudgetPeriodCustom = L10n.tr("Localizable", "choose_budget_period_custom", fallback: "Custom")
  /// Custom period
  internal static let chooseBudgetPeriodCustomPremium = L10n.tr("Localizable", "choose_budget_period_custom_premium", fallback: "Custom period")
  /// or
  internal static let chooseBudgetPeriodOr = L10n.tr("Localizable", "choose_budget_period_or", fallback: "or")
  /// Premium
  internal static let chooseBudgetPeriodPremium = L10n.tr("Localizable", "choose_budget_period_premium", fallback: "Premium")
  /// Choose
  internal static let chooseTitle = L10n.tr("Localizable", "Choose_title", fallback: "Choose")
  /// Choose your plan
  internal static let chooseYourPlan = L10n.tr("Localizable", "Choose_your_plan", fallback: "Choose your plan")
  /// Close
  internal static let closeTitle = L10n.tr("Localizable", "Close_title", fallback: "Close")
  /// Continue
  internal static let continueButton = L10n.tr("Localizable", "Continue_button", fallback: "Continue")
  /// Start budgeting now!
  internal static let createBudget = L10n.tr("Localizable", "create_budget", fallback: "Start budgeting now!")
  /// Daily
  internal static let dailyBudget = L10n.tr("Localizable", "Daily_budget", fallback: "Daily")
  /// (%@ days free)
  internal static func daysFree(_ p1: Any) -> String {
    return L10n.tr("Localizable", "Days_Free", String(describing: p1), fallback: "(%@ days free)")
  }
  /// Are you sure you want to delete this budget?
  internal static let deleteBudgetConfirmation = L10n.tr("Localizable", "delete_Budget_Confirmation", fallback: "Are you sure you want to delete this budget?")
  /// Dying tree, bad things happens, but you have a chance to recovery!
  internal static let dieTreeDescription = L10n.tr("Localizable", "DieTreeDescription", fallback: "Dying tree, bad things happens, but you have a chance to recovery!")
  /// Done
  internal static let doneTitle = L10n.tr("Localizable", "Done_title", fallback: "Done")
  /// Drag down to create new operation
  internal static let dragDownHint = L10n.tr("Localizable", "Drag_down_hint", fallback: "Drag down to create new operation")
  /// Drag up to see your last operations
  internal static let dragUpHint = L10n.tr("Localizable", "Drag_up_hint", fallback: "Drag up to see your last operations")
  /// Due
  internal static let due = L10n.tr("Localizable", "Due", fallback: "Due")
  /// Due today
  internal static let dueToday = L10n.tr("Localizable", "Due_Today", fallback: "Due today")
  /// Expenses
  internal static let expensesTitle = L10n.tr("Localizable", "Expenses_title", fallback: "Expenses")
  /// Expiration date: 
  internal static let expirationDate = L10n.tr("Localizable", "ExpirationDate", fallback: "Expiration date: ")
  /// Flexible budget
  internal static let flexibleBudget = L10n.tr("Localizable", "Flexible_budget", fallback: "Flexible budget")
  /// Set flexible period days for budgets
  internal static let flexibleBudgetDescriptions = L10n.tr("Localizable", "Flexible_budget_descriptions", fallback: "Set flexible period days for budgets")
  /// Excellent tree, keep doing and your tree would be fantastic!
  internal static let greenTreeDescription = L10n.tr("Localizable", "GreenTreeDescription", fallback: "Excellent tree, keep doing and your tree would be fantastic!")
  /// The most expensive categories
  internal static let homeCategory = L10n.tr("Localizable", "Home_category", fallback: "The most expensive categories")
  /// Learn more
  internal static let learnMore = L10n.tr("Localizable", "Learn_more", fallback: "Learn more")
  ///  and 
  internal static let mergeAnd = L10n.tr("Localizable", "Merge_And", fallback: " and ")
  /// Remaining
  internal static let moneyLeft = L10n.tr("Localizable", "Money_left", fallback: "Remaining")
  /// Used
  internal static let moneySpent = L10n.tr("Localizable", "Money_spent", fallback: "Used")
  /// Net Worth
  internal static let netWorth = L10n.tr("Localizable", "Net_Worth", fallback: "Net Worth")
  /// No ads
  internal static let noAds = L10n.tr("Localizable", "No_ads", fallback: "No ads")
  /// You won't see ads. You truly don't need this
  internal static let noAdsDescriptions = L10n.tr("Localizable", "No_ads_descriptions", fallback: "You won't see ads. You truly don't need this")
  /// OK
  internal static let okTitle = L10n.tr("Localizable", "OK_title", fallback: "OK")
  /// Bonsai represents the money tree. Set financial goals, track your money flow, notice your financial habits.
  internal static let onboarding1Description = L10n.tr("Localizable", "Onboarding_1_description", fallback: "Bonsai represents the money tree. Set financial goals, track your money flow, notice your financial habits.")
  /// Welcome!
  internal static let onboarding1Title = L10n.tr("Localizable", "Onboarding_1_title", fallback: "Welcome!")
  /// Just using your phone, you can manage all your cashflow more easy and detailed.
  internal static let onboarding2Description = L10n.tr("Localizable", "Onboarding_2_description", fallback: "Just using your phone, you can manage all your cashflow more easy and detailed.")
  /// Manage your money with ease
  internal static let onboarding2Title = L10n.tr("Localizable", "Onboarding_2_title", fallback: "Manage your money with ease")
  /// Be mindful spending, and you will be closer to financial freedom.
  internal static let onboarding3Description = L10n.tr("Localizable", "Onboarding_3_description", fallback: "Be mindful spending, and you will be closer to financial freedom.")
  /// Be more mindful spending
  internal static let onboarding3Title = L10n.tr("Localizable", "Onboarding_3_title", fallback: "Be more mindful spending")
  /// Orange tree, something goes wrong, try to reduce your daily expenses!
  internal static let orangeTreeDescription = L10n.tr("Localizable", "OrangeTreeDescription", fallback: "Orange tree, something goes wrong, try to reduce your daily expenses!")
  /// Other
  internal static let otherTitle = L10n.tr("Localizable", "Other_title", fallback: "Other")
  /// out of
  internal static let outOf = L10n.tr("Localizable", "out_of", fallback: "out of")
  /// Period
  internal static let periodTitle = L10n.tr("Localizable", "Period_title", fallback: "Period")
  /// Premium subscription unleashes full power of bonsai. No limits, no ads, custom icons and more
  internal static let premiumDescriptions = L10n.tr("Localizable", "premium_descriptions", fallback: "Premium subscription unleashes full power of bonsai. No limits, no ads, custom icons and more")
  /// With a premium subscription you get unlimited access to the functionality.
  internal static let premiumPlanDescription = L10n.tr("Localizable", "premium_planDescription", fallback: "With a premium subscription you get unlimited access to the functionality.")
  /// Privacy Policy
  internal static let privacyPolicy = L10n.tr("Localizable", "Privacy_Policy", fallback: "Privacy Policy")
  /// Purchase date: 
  internal static let purchaseDate = L10n.tr("Localizable", "PurchaseDate", fallback: "Purchase date: ")
  /// Purple tree, try to use money more wisly and keep going!
  internal static let purpleTreeDescription = L10n.tr("Localizable", "PurpleTreeDescription", fallback: "Purple tree, try to use money more wisly and keep going!")
  /// Restore Purchases
  internal static let restorePurchases = L10n.tr("Localizable", "Restore_Purchases", fallback: "Restore Purchases")
  /// Revenue
  internal static let revenueTitle = L10n.tr("Localizable", "Revenue_title", fallback: "Revenue")
  /// Save
  internal static let saveTitle = L10n.tr("Localizable", "Save_title", fallback: "Save")
  /// Сподіваюсь, що поряд з тобою твої близькі люди і ви всі у безпеці. Дякую тобі, що ти з нами! Одного дня усі жахіття закінчаться нашою перемогою. Ти знаєш шо потрібно робити, Слава Україні!
  internal static let specialForUA = L10n.tr("Localizable", "special_for_UA", fallback: "Сподіваюсь, що поряд з тобою твої близькі люди і ви всі у безпеці. Дякую тобі, що ти з нами! Одного дня усі жахіття закінчаться нашою перемогою. Ти знаєш шо потрібно робити, Слава Україні!")
  /// Повністю безкоштовна довічна підписка для українців
  internal static let specialForUATitle = L10n.tr("Localizable", "special_for_UA_title", fallback: "Повністю безкоштовна довічна підписка для українців")
  /// Your subscription has been completed.
  internal static let subscriptionComplete = L10n.tr("Localizable", "subscription_complete", fallback: "Your subscription has been completed.")
  /// By subscribing you agree to our 
  internal static let subscriptionDescription = L10n.tr("Localizable", "Subscription_description", fallback: "By subscribing you agree to our ")
  /// Cancel anytime. Subscription auto-renews.
  internal static let subscriptionDescription1 = L10n.tr("Localizable", "Subscription_description_1", fallback: "Cancel anytime. Subscription auto-renews.")
  /// month
  internal static let subscriptionsMonth = L10n.tr("Localizable", "subscriptions_month", fallback: "month")
  /// of target
  internal static let targetTitle = L10n.tr("Localizable", "Target_title", fallback: "of target")
  /// Terms & Conditions
  internal static let termsOfService = L10n.tr("Localizable", "Terms_of_Service", fallback: "Terms & Conditions")
  /// This month
  internal static let thisMonth = L10n.tr("Localizable", "This_month", fallback: "This month")
  /// Total
  internal static let totalBudget = L10n.tr("Localizable", "Total_budget", fallback: "Total")
  /// Operations
  internal static let transactionsTitle = L10n.tr("Localizable", "Transactions_title", fallback: "Operations")
  /// Tree progress
  internal static let treeProgress = L10n.tr("Localizable", "TreeProgress", fallback: "Tree progress")
  /// Start Trial and Subscribe
  internal static let tryForFree = L10n.tr("Localizable", "Try_for_free", fallback: "Start Trial and Subscribe")
  /// Unlimited categories
  internal static let unlimitedCategories = L10n.tr("Localizable", "Unlimited_categories", fallback: "Unlimited categories")
  /// You can create unlimited categories, feel free to specify your operation
  internal static let unlimitedCategoriesDescriptions = L10n.tr("Localizable", "Unlimited_categories_descriptions", fallback: "You can create unlimited categories, feel free to specify your operation")
  /// Unlimited tags
  internal static let unlimitedTags = L10n.tr("Localizable", "Unlimited_tags", fallback: "Unlimited tags")
  /// Get unlimited opportunity to add tags for your needs
  internal static let unlimitedTagsDescriptions = L10n.tr("Localizable", "Unlimited_tags_descriptions", fallback: "Get unlimited opportunity to add tags for your needs")
  /// Budget unlocks your beautiful bonsai tree
  internal static let unlockBudget = L10n.tr("Localizable", "unlock_budget", fallback: "Budget unlocks your beautiful bonsai tree")
  /// You don't own a budget yet
  internal static let youDontOwnABudgetYet = L10n.tr("Localizable", "you_dont_own_a_budget_yet", fallback: "You don't own a budget yet")
  internal enum SelectCurrencyPage {
    /// Choose
    internal static let choose = L10n.tr("Localizable", "SelectCurrencyPage.Choose", fallback: "Choose")
    /// Choose default currency
    internal static let chooseDefaultCurrency = L10n.tr("Localizable", "SelectCurrencyPage.Choose_default_currency", fallback: "Choose default currency")
    /// Confirm
    internal static let confirm = L10n.tr("Localizable", "SelectCurrencyPage.Confirm", fallback: "Confirm")
  }
  internal enum Budget {
    /// Amount
    internal static let amount = L10n.tr("Localizable", "budget.amount", fallback: "Amount")
    /// Create
    internal static let create = L10n.tr("Localizable", "budget.create", fallback: "Create")
    /// Budget
    internal static let defaultName = L10n.tr("Localizable", "budget.default_name", fallback: "Budget")
    /// Edit Budget
    internal static let edit = L10n.tr("Localizable", "budget.edit", fallback: "Edit Budget")
    /// Name (optional)
    internal static let name = L10n.tr("Localizable", "budget.name", fallback: "Name (optional)")
    /// New Budget
    internal static let new = L10n.tr("Localizable", "budget.new", fallback: "New Budget")
    /// Save
    internal static let save = L10n.tr("Localizable", "budget.save", fallback: "Save")
    /// Drag up to see budget operations
    internal static let swipeUpSuggestion = L10n.tr("Localizable", "budget.swipe_up_suggestion", fallback: "Drag up to see budget operations")
    internal enum Delete {
      /// Delete budget
      internal static let button = L10n.tr("Localizable", "budget.delete.button", fallback: "Delete budget")
      /// Yes, delete my budget
      internal static let confirmation = L10n.tr("Localizable", "budget.delete.confirmation", fallback: "Yes, delete my budget")
    }
  }
  internal enum Category {
    /// Category Name
    internal static let name = L10n.tr("Localizable", "category.name", fallback: "Category Name")
    /// New Category
    internal static let new = L10n.tr("Localizable", "category.new", fallback: "New Category")
    /// No category
    internal static let noCategory = L10n.tr("Localizable", "category.no_category", fallback: "No category")
    /// Categories
    internal static let title = L10n.tr("Localizable", "category.title", fallback: "Categories")
  }
  internal enum Charts {
    internal enum Balance {
      /// This chart will show you how your balance changes over time
      internal static let empty = L10n.tr("Localizable", "charts.balance.empty", fallback: "This chart will show you how your balance changes over time")
      /// Balance
      internal static let title = L10n.tr("Localizable", "charts.balance.title", fallback: "Balance")
    }
    internal enum Expenses {
      /// This chart will show all categories that you spent money on
      internal static let empty = L10n.tr("Localizable", "charts.expenses.empty", fallback: "This chart will show all categories that you spent money on")
      /// Expenses
      internal static let title = L10n.tr("Localizable", "charts.expenses.title", fallback: "Expenses")
    }
    internal enum Legend {
      /// Amount (%@)
      internal static func amount(_ p1: Any) -> String {
        return L10n.tr("Localizable", "charts.legend.amount", String(describing: p1), fallback: "Amount (%@)")
      }
      /// Balance
      internal static let balance = L10n.tr("Localizable", "charts.legend.balance", fallback: "Balance")
      /// Time Period
      internal static let period = L10n.tr("Localizable", "charts.legend.period", fallback: "Time Period")
    }
  }
  internal enum Date {
    /// Today
    internal static let today = L10n.tr("Localizable", "date.today", fallback: "Today")
    /// Yesterday
    internal static let yesterday = L10n.tr("Localizable", "date.yesterday", fallback: "Yesterday")
  }
  internal enum Operation {
    /// Add Tag
    internal static let addTag = L10n.tr("Localizable", "operation.add_tag", fallback: "Add Tag")
    /// Amount
    internal static let amount = L10n.tr("Localizable", "operation.amount", fallback: "Amount")
    /// Category
    internal static let category = L10n.tr("Localizable", "operation.category", fallback: "Category")
    /// Edit Operation
    internal static let edit = L10n.tr("Localizable", "operation.edit", fallback: "Edit Operation")
    /// Expense
    internal static let expense = L10n.tr("Localizable", "operation.expense", fallback: "Expense")
    /// Revenue
    internal static let income = L10n.tr("Localizable", "operation.income", fallback: "Revenue")
    /// New Operation
    internal static let new = L10n.tr("Localizable", "operation.new", fallback: "New Operation")
    /// Title
    internal static let title = L10n.tr("Localizable", "operation.title", fallback: "Title")
    /// Transfer
    internal static let transfer = L10n.tr("Localizable", "operation.transfer", fallback: "Transfer")
  }
  internal enum Settings {
    /// Privacy Policy
    internal static let policy = L10n.tr("Localizable", "settings.policy", fallback: "Privacy Policy")
    /// Premium Features
    internal static let premiumFeatures = L10n.tr("Localizable", "settings.premium_features", fallback: "Premium Features")
    /// Terms of Service
    internal static let terms = L10n.tr("Localizable", "settings.terms", fallback: "Terms of Service")
  }
  internal enum Tags {
    /// Tag Name
    internal static let name = L10n.tr("Localizable", "tags.name", fallback: "Tag Name")
    /// New Tag
    internal static let new = L10n.tr("Localizable", "tags.new", fallback: "New Tag")
    /// Localizable.strings
    ///   bonsai
    /// 
    ///   Created by antuan.khoanh on 06/09/2022.
    internal static let title = L10n.tr("Localizable", "tags.title", fallback: "Tags")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
