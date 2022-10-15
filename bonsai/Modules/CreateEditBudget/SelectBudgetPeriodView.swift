//
//  SelectBudgetPeriod.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/10/2022.
//

import SwiftUI

struct SelectBudgetPeriodView: View {
   @State private var amount: String
   @State private var title: String

   init() {
      self._amount = .init(initialValue: "")
      self._title = .init(initialValue: "")
   }
   
   private enum Period: String {
      case week = "Weekly"
      case twoWeek = "2 Week"
      case month = "Month"
      case custom = "Custom"
   }
   
   private let items: [Period] = [.week, .twoWeek, .month, .custom]
   
   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
               VStack {
                  ForEach(Array(items.enumerated()), id: \.offset) { index, element  in
                     
                     SelectedDateRow(item: element.rawValue) { }
                  }
                  
                  Spacer()
                  
                  Button {
                     
                  } label: {
                     ZStack {
                        RoundedRectangle(cornerRadius: 13)
                           .frame(width: 192, height: 48)
                           .foregroundColor(BonsaiColor.mainPurple)
                        Text("Choose")
                           .foregroundColor(BonsaiColor.card)
                           .font(.system(size: 17))
                           .bold()
                     }
                  }
                  .padding(.bottom, 16)
                  
                  .disabled(amount.isEmpty && title.isEmpty)
               } //VStack
            }.navigationTitle("Period")
         }
   }
}

struct SelectBudgetPeriod_Previews: PreviewProvider {
   static var previews: some View {
      SelectBudgetPeriodView()
   }
}

struct SelectedDateRow: View {
   let item: String
   let onTap: (() -> Void)?
   var isSelected: Bool = false
   
   var body: some View {
      RoundedRectangle(cornerRadius: 13)
         .frame(height: 44)
         .foregroundColor(BonsaiColor.card)
         .overlay {
            HStack {
               Text(item).font(.headline)
                  .foregroundColor(.secondary)
                  .padding(.leading, 16)
               Spacer()
            }.onTapGesture {
               onTap?()
            }
            .background(BonsaiColor.card)
            .contentShape(Rectangle())
            selectingRow()
         }
         .padding([.leading, .trailing], 16)
   }
   
   private func selectingRow() -> some View {
      RoundedRectangle(cornerRadius: 13)
         .stroke(
            { () -> Color in
               if isSelected {
                  return BonsaiColor.mainPurple
               } else {
                  return .clear
               }
            }(),
            lineWidth: 2
         )
   }
}
