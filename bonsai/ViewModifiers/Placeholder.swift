//
//  Placeholder.swift
//  bonsai
//
//  Created by Vladimir Korolev on 12.12.2021.
//

import SwiftUI

struct Placeholder<T: View>: ViewModifier {

   var placeholder: T
   var show: Bool

   func body(content: Content) -> some View {
       ZStack(alignment: .leading) {
           if show { placeholder }
           content
       }
   }
}

extension View {
    func placeholder<T: View>(_ holder: T, show: Bool) -> some View {
        modifier(Placeholder(placeholder: holder, show: show))
    }
}
