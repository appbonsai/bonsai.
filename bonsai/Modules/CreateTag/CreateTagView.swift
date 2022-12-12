//
//  CreateTagView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 19.06.2022.
//

import SwiftUI

struct CreateTagView: View {

    @Environment(\.managedObjectContext) private var moc
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @FocusState private var fieldIsFocused: Bool

    let completion: ((Tag?) -> Void)?

    var body: some View {
        NavigationView {
            ZStack {
                BonsaiColor.back
                    .ignoresSafeArea()

                CategoryNewTitleView(
                    title: $title,
                    placeholder: "tags.name"
                )
                .focused($fieldIsFocused)
                .frame(height: 56, alignment: .center)
                .background(SwiftUI.Color(hex: 0x3d3c4d))
                .cornerRadius(13)
                .padding([.bottom, .leading, .trailing, .top], 16)
            } // ZStack
            .navigationTitle(LocalizedStringKey("tags.new"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented = false
                        completion?(nil)
                    }) {
                        Text(LocalizedStringKey("Cancel_title"))
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
                        Text(LocalizedStringKey("Done_title"))
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
        CreateTagView(isPresented: .constant(true), completion: nil)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
