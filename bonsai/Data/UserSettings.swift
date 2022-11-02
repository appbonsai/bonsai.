//
//  UserSettings.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12/10/22.
//

enum UserSettings {
   @NonNilUserDefault("is onboarding seen", defaultValue: false)
   static var isOnboardingSeen: Bool

   // count number of new operation opened to hide drag down hint later
   @NonNilUserDefault("drags_down_count", defaultValue: 0)
   private(set) static var countOfDragsDown: Int

   static func incrementCountOfDragsDown() {
      // to avoid int max overflowing
      countOfDragsDown = min(10, countOfDragsDown + 1)
   }

   static var showDragDownHint: Bool {
      countOfDragsDown <= 4
   }
}
