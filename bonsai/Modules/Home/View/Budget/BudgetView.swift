//
//  BudgetView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 07.12.2021.
//

import SwiftUI

struct CircularProgressView: View {

   let progress: Double

   var body: some View {
      ZStack {
         Circle()
            .stroke(
               BonsaiColor.text.opacity(0.5),
               lineWidth: 10
            )
         Circle()
            .trim(from: 0, to: progress)
            .stroke(
               BonsaiColor.text,
               style: StrokeStyle(
                  lineWidth: 10,
                  lineCap: .round
               )
            )
            .rotationEffect(.degrees(-90))
         // 1
            .animation(.easeOut, value: progress)

      }
   }
}

struct BudgetView: View {

   let data: Array<(Category, Decimal)>

   @State var progress: Double = 0.7

   var body: some View {
      ZStack {
         BonsaiColor.card
            .blur(radius: 1)
            .opacity(0.8)
         VStack(alignment: .leading, spacing: 0) {
            
            BudgetHeaderView(progress: $progress)
               .cornerRadius(13)
               .opacity(0.8)

            if data.count > 0 {
               Text(LocalizedStringKey("Home_category"))
                  .font(BonsaiFont.subtitle_15)
                  .foregroundColor(BonsaiColor.text)
                  .padding(.top, 16)
                  .padding(.horizontal, 16)
                  .padding(.bottom, 8)
            }

            VStack(spacing: 8) {
               ForEach(data, id: \.0) { (category, amount) in

                  BudgetCellView(
                     title: category.title,
                     amount: (amount as NSDecimalNumber).intValue,
                     color: category.color.asGradient,
                     icon: category.image
                  )
                  .padding(.bottom, 8)
               }
            }
            .padding(.horizontal, 16)
         }
      }
   }
}
struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView(data: [])
            .previewLayout(.fixed(width: 358, height:330))
            .environmentObject(
                BudgetCalculator()
            )
    }
}
