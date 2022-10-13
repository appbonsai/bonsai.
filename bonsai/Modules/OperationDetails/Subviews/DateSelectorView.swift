//
//  DateSelectorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 19.06.2022.
//

import SwiftUI

struct DateSelectorView: View {

   @Binding var date: Date
   @Binding var fullSized: Bool

   var dateText: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd MMMM YYYY"
      return dateFormatter.string(from: date)
   }
   
   let isClosedRange: Bool

   var body: some View {
      VStack {
         ZStack {
            BonsaiColor.card
            HStack(spacing: 8) {
               BonsaiImage.calendar
                  .renderingMode(.template)
                  .foregroundColor(BonsaiColor.purple3)
                  .padding([.leading, .top, .bottom], 16)
               Text(fullSized ? "Date" : dateText)
                  .foregroundColor(BonsaiColor.purple3)
                  .font(BonsaiFont.body_17)
               Spacer()
               (fullSized ? BonsaiImage.chevronUp : BonsaiImage.chevronDown)
                  .renderingMode(.template)
                  .padding([.trailing], 24)
                  .foregroundColor(BonsaiColor.purple3)
            } // HStack
         } // ZStack
         .onTapGesture {
            withAnimation {
               fullSized.toggle()
            }
         }

         if fullSized {
            datePickerIn()
            .datePickerStyle(.graphical)
            .accentColor(BonsaiColor.purple3)
            .padding([.leading, .trailing])
         }
      }
      .background(BonsaiColor.card)
   }
   
   func datePickerIn() -> some View {
      if isClosedRange {
         return DatePicker(
            "",
            selection: $date,
            in: Date().addingTimeInterval(-10000000)...Date(),
            displayedComponents: .date
         )
      } else {
         return DatePicker(
            "",
            selection: $date,
            in: Date()...,
            displayedComponents: .date
         )
      }
   }
}

struct DateSelectorView_Previews: PreviewProvider {
   static var previews: some View {
      DateSelectorView(
         date: .constant(Date()), fullSized: .constant(false), isClosedRange: false
      )
   }
}
