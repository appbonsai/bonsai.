//
//  SubscriptionCell.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct SubscriptionCell: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 13)
            .frame(height: 76)
            .foregroundColor(BonsaiColor.card)
            .overlay {
                HStack(alignment: .center) {
                    Image("path_checkbox")
                        .padding([.leading,.trailing], 18)
                    VStack(alignment: .leading) {
                        Text("Monthly")
                            .foregroundColor(BonsaiColor.purple7)
                            .font(.system(size: 17))
                            .padding(.bottom, 2)
                        Text("$4 per month")
                            .foregroundColor(BonsaiColor.purple3)
                            .font(.system(size: 17))
                    }
                    Spacer()
                }
            }
    }
}

struct SubscriptionCell_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCell()
    }
}
