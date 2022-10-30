//
//  BarChartLineView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 03.07.2022.
//

import SwiftUI

struct BarChartLineView: View {
   var value: Double
   var color: Color
   var cornerRadius: CGFloat = 4

   var body: some View {
      Rectangle()
         .cornerRadius(cornerRadius)
         .foregroundColor(color)
         .scaleEffect(CGSize(width: 1, height: value), anchor: .bottom)
   }
}

struct BarChartLineView_Previews: PreviewProvider {
   static var previews: some View {
      BarChartLineView(value: 6, color: BonsaiColor.mainPurple)
         .previewLayout(.fixed(width: 100, height: 100))
   }
}
