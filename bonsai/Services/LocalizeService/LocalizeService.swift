//
//  LocalizeService.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/09/2022.
//

import Foundation

typealias L = LocalizeService

class LocalizeService {

   static let onboarding_1_title = "Onboarding_1_title".localized()
   static let onboarding_1_description = "Onboarding_1_description".localized()

   static let onboarding_2_title = "Onboarding_2_title".localized()
   static let onboarding_2_description = "Onboarding_2_description".localized()

   static let onboarding_3_title = "Onboarding_3_title".localized()
   static let onboarding_3_description = "Onboarding_3_description".localized()


   static let Money_left = "Money_left".localized()
   static let Money_spent = "Money_spent".localized()
   static let Total_budget = "Total_budget".localized()
   static let Daily_budget = "Daily_budget".localized()
   static let Budget_greeting = "Budget_greeting".localized()
   static let Drag_up_hint = "Drag_up_hint".localized()
   static let Drag_down_hint = "Drag_down_hint".localized()
   static let Home_category = "Home_category".localized()
   static let Revenue_title = "Revenue_title".localized()
   static let Expenses_title = "Expenses_title".localized()
   static let Budget_title = "Budget_title".localized()
   static let Target_title = "Target_title".localized()
   static let Onboarding_1_title = "Onboarding_1_title".localized()
   static let Onboarding_2_title = "Onboarding_2_title".localized()
   static let Onboarding_3_title = "Onboarding_3_title".localized()
   static let Onboarding_1_text = "Onboarding_1_text".localized()
   static let Onboarding_2_text = "Onboarding_2_text".localized()
   static let Onboarding_3_text = "Onboarding_3_text".localized()
   static let Continue_button = "Continue_button".localized()
   static let Try_for_free = "Try_for_free".localized()
   static let AllSet_title = "AllSet_title".localized()

   static let AllSet_text = "AllSet_text".localized()
   static let Best_value = "Best_value".localized()
   static let Choose_your_plan = "Choose_your_plan".localized()
   static let Subscription_description_1 = "Subscription_description_1".localized()
   static let Subscription_description = "Subscription_description".localized()
   static let Merge_And = "Merge_And".localized()
   static let Terms_of_Service = "Terms_of_Service".localized()
   static let Privacy_Policy = "Privacy_Policy".localized()
   static let Restore_Purchases = "Restore_Purchases".localized()

   static let Due = "Due".localized()
   static let Due_Today = "Due_Today".localized()
   static func Days_Free(_ days: Int) -> String { "Days_Free".localized(args: [String(days)]) }

   // SelectCurrencyPage


   enum SelectCurrencyPage {
      static let Choose = "SelectCurrencyPage.Choose".localized()
      static let Confirm = "SelectCurrencyPage.Confirm".localized()
      static let Choose_default_currency = "SelectCurrencyPage.Choose_default_currency".localized()
   }
   
   static let transactions_title = "Transactions_title".localized()
   static let cancel = "Cancel_title".localized()
   static let done = "Done_title".localized()

   
   static let other = "Other_title".localized()
   static let charts = "Charts_title".localized()
   static let period = "Period_title".localized()
   static let choose = "Choose_title".localized()
   static let budget_until = "Budget_until_title".localized()
   static let save = "Save_title".localized()   
   static let close = "Close_title".localized()
   static let back = "Back_title".localized()
   static let ok = "OK_title".localized()

   static let deleteBudgetConfirmation = "delete_Budget_Confirmation".localized()
    
    
    
   static let Bonsai_premium_features = "Bonsai_premium_features".localized()
   
   static let ownBudget = "you_dont_own_a_budget_yet".localized()
   static let unlock_budget = "unlock_budget".localized()
   static let create_budget = "create_budget".localized()

   static let choose_budget_period_or = "choose_budget_period_or".localized()
   static let choose_budget_period_custom = "choose_budget_period_custom".localized()
   
   static let choose_budget_period_premium = "choose_budget_period_premium".localized()
   
   static let choose_budget_period_custom_premium = "choose_budget_period_custom_premium".localized()
   
   static let This_month = "This_month".localized()
   
   static let Net_Worth = "Net_Worth".localized()
   static let Learn_more = "Learn_more".localized()
   static let subscriptions_month = "subscriptions_month".localized()
   static let out_of = "out_of".localized()

   static let premium_descriptions = "premium_descriptions".localized()
   static let premium_planDescription = "premium_planDescription".localized()
   
   static let Unlimited_categories = "Unlimited_categories".localized()
   
   static let Unlimited_categories_descriptions = "Unlimited_categories_descriptions".localized()
   static let Unlimited_tags = "Unlimited_tags".localized()
   static let Unlimited_tags_descriptions = "Unlimited_tags_descriptions".localized()
   static let Flexible_budget = "Flexible_budget".localized()
   static let Flexible_budget_descriptions = "Flexible_budget_descriptions".localized()
   static let No_ads = "No_ads".localized()
   static let No_ads_descriptions = "No_ads_descriptions".localized()
   
   static let special_for_UA_title = "special_for_UA_title".localized()
   static let special_for_UA = "special_for_UA".localized()

}

