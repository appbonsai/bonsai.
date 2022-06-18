// Thx
// https://github.com/FiveStarsBlog/CodeSamples/tree/48e493a2b4acd7196c176689a8f3038936f0ed41/Flexible-SwiftUI

import SwiftUI

/// Facade of our view, its main responsibility is to get the available width
/// and pass it down to the real implementation, `_FlexibleView`.
struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
   let data: Data
   let spacing: CGFloat
   let alignment: HorizontalAlignment
   let content: (Data.Element) -> Content
   @State private var availableWidth: CGFloat = 0
   
   var body: some View {
      ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
         Color.clear
            .frame(height: 1)
            .readSize { size in
               availableWidth = size.width
            }
         
         _FlexibleView(
            availableWidth: availableWidth,
            data: data,
            spacing: spacing,
            alignment: alignment,
            content: content
         )
      }
   }
}
