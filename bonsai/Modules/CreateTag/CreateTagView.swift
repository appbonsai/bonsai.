//
//  CreateTagView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 19.06.2022.
//

import SwiftUI

struct CreateTagView: View {

   @Environment(\.managedObjectContext) private var moc
   @Binding private var isPresented: Bool
   @State private var title: String = ""

   init(isPresented: Binding<Bool>) {
      self._isPresented = isPresented
      UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()

            CategoryNewTitleView(
               title: $title,
               placeholder: "Tag Name"
            )
            .frame(height: 56, alignment: .center)
            .background(SwiftUI.Color(hex: 0x3d3c4d))
            .cornerRadius(13)
            .padding([.bottom, .leading, .trailing, .top], 16)
         } // ZStack
         .navigationTitle("New Tag")
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               Button(action: { isPresented = false }) {
                  Text("Cancel")
               }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
               Button(action: {
                  guard title.isEmpty == false else {
                     assertionFailure("title was empty, save is not allowed")
                     return
                  }
                  Tag(context: moc, title: title)
                  try? moc.save()
                  isPresented = false
               }) {
                  Text("Done")
               }
               .disabled($title.wrappedValue.isEmpty)
            }
         }
      } // NavigationView
   }
}

struct CreateTagView_Previews: PreviewProvider {
   static var previews: some View {
      CreateTagView(isPresented: .constant(true))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
