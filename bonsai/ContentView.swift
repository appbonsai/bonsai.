//
//  ContentView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.12.2021.
//

import SwiftUI

struct ContentView: View {

   @State private var isPresented = false

   var body: some View {
      BarChartView(viewModel: BarChartViewModel())
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
