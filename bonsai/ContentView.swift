//
//  ContentView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.12.2021.
//

import SwiftUI

struct ContentView: View {

   @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
   @State private var isPresented = false

   var body: some View {
      VStack {
         ForEach(categories) { category in
            Text("category=\(category.title);\(category.color.rawValue)'\(category.icon.rawValue)")
         }
         Button("Present") {
            isPresented.toggle()
         }
         .popover(isPresented: $isPresented) {
            CreateCategoryView(isPresented: $isPresented)
         }
      }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
