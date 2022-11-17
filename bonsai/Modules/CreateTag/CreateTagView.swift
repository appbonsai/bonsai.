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
   @FocusState private var fieldIsFocused: Bool

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
               placeholder: L.Tags.name
            )
            .focused($fieldIsFocused)
            .frame(height: 56, alignment: .center)
            .background(SwiftUI.Color(hex: 0x3d3c4d))
            .cornerRadius(13)
            .padding([.bottom, .leading, .trailing, .top], 16)
         } // ZStack
         .navigationTitle(L.Tags.new)
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               Button(action: {
                  isPresented = false
                  completion?(nil)
               }) {
                  Text(L.cancelTitle)
                     .foregroundColor(BonsaiColor.secondary)
               }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
               Button(action: {
                  guard title.isEmpty == false else {
                     assertionFailure("title was empty, save is not allowed")
                     return
                  }
                  // todo prevent tags with same title
                  let tag = Tag(context: moc, title: title)
                  do {
                     try moc.save()
                  } catch (let e) {
                     assertionFailure(e.localizedDescription)
                  }
                  isPresented = false
                  completion?(tag)
               }) {
                  Text(L.doneTitle)
                     .if($title.wrappedValue.isEmpty == false, transform: { text in
                        text.foregroundColor(BonsaiColor.secondary)
                     })
               }
               .disabled($title.wrappedValue.isEmpty)
            }
         }
      } // NavigationView
      .onAppear {
         fieldIsFocused = true
      }
   }
}

struct CreateTagView_Previews: PreviewProvider {
   static var previews: some View {
      CreateTagView(isPresented: .constant(true))
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
