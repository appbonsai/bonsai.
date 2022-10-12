//
//  UserSettings.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12/10/22.
//

enum UserSettings {
   @NonNilUserDefault("is onboarding seen", defaultValue: false)
   static var isOnboardingSeen: Bool
}
