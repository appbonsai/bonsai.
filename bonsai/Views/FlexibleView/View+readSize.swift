// Thx
// https://github.com/FiveStarsBlog/CodeSamples/tree/48e493a2b4acd7196c176689a8f3038936f0ed41/Flexible-SwiftUI

import SwiftUI

extension View {
   func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
      background(
         GeometryReader { geometryProxy in
            Color.clear
               .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
         }
      )
      .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
   }
}

private struct SizePreferenceKey: PreferenceKey {
   static var defaultValue: CGSize = .zero
   static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
