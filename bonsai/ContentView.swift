//
//  ContentView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.12.2021.
//

import SwiftUI

struct ContentView: View {

   var body: some View {
      CreateEditBudget()
//      if UserSettings.isOnboardingSeen {
//         TabBar()
//      } else {
//         Onboarding()
//      }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
