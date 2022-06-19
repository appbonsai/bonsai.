//
//  DateSelectorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 19.06.2022.
//

import SwiftUI

struct DateSelectorView: View {

   @Binding var date: Date
   @State var fullSized: Bool = false

   var dateText: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd MMMM YYYY"
      return dateFormatter.string(from: date)
   }

   var body: some View {
      VStack {
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
         }.onTapGesture {
            withAnimation {
               fullSized.toggle()
            }
         }
         if fullSized {
            DatePicker(
               "",
               selection: $date,
               in: Date().addingTimeInterval(-10000000)...Date(),
               displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .accentColor(BonsaiColor.purple3)
            .padding([.leading, .trailing])
         }
      }
      .background(BonsaiColor.card)
   }
}

struct DateSelectorView_Previews: PreviewProvider {
   static var previews: some View {
      DateSelectorView(
         date: .constant(Date())
      )
   }
}
