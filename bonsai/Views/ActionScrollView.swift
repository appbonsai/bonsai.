//
//  ActionScrollView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 02.07.2022.
//

import SwiftUI

private enum PositionType {
   case fixed, moving
}
private struct Position: Equatable {
   let type: PositionType
   let y: CGFloat
}
private struct PositionPreferenceKey: PreferenceKey {
   typealias Value = [Position]
   static var defaultValue = [Position]()
   static func reduce(value: inout [Position], nextValue: () -> [Position]) {
      value.append(contentsOf: nextValue())
   }
}
private struct PositionIndicator: View {
   let type: PositionType

   var body: some View {
      GeometryReader { proxy in
         Color.clear
            .preference(
               key: PositionPreferenceKey.self,
               value: [Position(type: type, y: proxy.frame(in: .global).minY)]
            )
      }
   }
}

struct ActionScrollView<ActionView, Content>: View where ActionView: View, Content: View {

   let threshold: CGFloat // what height do you have to pull down to trigger the callback
   let onDone: (() -> Void) -> Void
   let icon: ActionViewBuilder<ActionView>
   let content: () -> Content
   @SwiftUI.State private var offset: CGFloat = 0
   @SwiftUI.State private var state = State.idle

   let feedbackGenerator = UINotificationFeedbackGenerator()

   typealias ActionViewBuilder<Progress: View> = (State) -> Progress

   enum State: Equatable {
      case idle, increasing(CGFloat), done
   }

   init(
      threshold: CGFloat = 100,
      onDone: @escaping (() -> Void) -> Void,
      @ViewBuilder progress: @escaping ActionViewBuilder<ActionView>,
      @ViewBuilder content: @escaping () -> Content
   ) {
      self.threshold = threshold
      self.onDone = onDone
      self.icon = progress
      self.content = content
   }

   public var body: some View {
      ScrollView() {
         ZStack(alignment: .top) {
            PositionIndicator(type: .moving).frame(height: 0)

            content()

            icon(state).offset(y: -40)
         }
      } // ScrollView
      .background(PositionIndicator(type: .fixed))
      .onPreferenceChange(PositionPreferenceKey.self) { values in

         if state == .done { return }

         let movingY = values.first { $0.type == .moving }?.y ?? 0
         let fixedY = values.first { $0.type == .fixed }?.y ?? 0
         offset = max(0, movingY - fixedY)

         if offset < threshold {
            state = .increasing(offset)
         }
         else if offset >= threshold, case .increasing = state {
            feedbackGenerator.notificationOccurred(.success)
            state = .done
            onDone { state = .idle }
         }
      } // onPreferenceChange
   }
}

