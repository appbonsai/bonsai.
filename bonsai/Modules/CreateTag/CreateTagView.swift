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

   private var completion: ((Tag?) -> Void)?

   init(isPresented: Binding<Bool>, completion: ((Tag?) -> Void)? = nil) {
      self._isPresented = isPresented
      self.completion = completion
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
               Button(action: {
                  isPresented = false
                  completion?(nil)
               }) {
                  Text("Cancel")
                     .foregroundColor(BonsaiColor.secondary)
               }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
               Button(action: {
                  guard title.isEmpty == false else {
                     assertionFailure("title was empty, save is not allowed")
                     return
                  }
                  let tag = Tag(context: moc, title: title)
                  do {
                     try moc.save()
                  } catch (let e) {
                     assertionFailure(e.localizedDescription)
                  }
                  isPresented = false
                  completion?(tag)
               }) {
                  Text("Done")
                     .if($title.wrappedValue.isEmpty == false, transform: { text in
                        text.foregroundColor(BonsaiColor.secondary)
                     })
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
