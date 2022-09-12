//
//  SubscriptionCell.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct SubscriptionCell: View {
    
    private let subscription: Subscription
    private let id: String
    private var isSelected: Bool {
       id.isEmpty ? subscription.isMostPopular : subscription.id == id
    }
    
    init(subscription: Subscription, id: String) {
        self.subscription = subscription
        self.id = id
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 13)
            .frame(height: 76)
            .foregroundColor(BonsaiColor.card)
            .overlay {
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
                    ).shimmering(duration: subscription.isMostPopular ? 3 : 0)
                HStack {
                    Image(isSelected ? "path_checked" : "path_checkbox")
                        .padding([.leading,.trailing], 18)
                    
                    VStack(alignment: .leading) {
                        Text(subscription.periodName)
                            .foregroundColor(BonsaiColor.text)
                            .font(.system(size: 17))
                            .bold()
                            .padding(.bottom, 2)
                        Text("\(subscription.price) / month")
                            .foregroundColor(BonsaiColor.purple3)
                            .font(.system(size: 17))
                    }
                    if subscription.isMostPopular {
                        HStack {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .frame(width: L.Best_value.widthOfString(usingFont: .systemFont(ofSize: 12), inset: 20), height: 22)
                                    .foregroundColor(BonsaiColor.green)
                                Text(L.Best_value)
                                    .foregroundColor(BonsaiColor.card)
                                    .font(.system(size: 12))
                            }
                            .padding(.trailing, 4)
                            .padding(.bottom, 38)
                        }
                        .shimmering(duration: 3)
                    }
                    Spacer()
                }
            }
    }
}

struct SubscriptionCell_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCell(subscription: MockSubscriptions.subscriptions.first!, id: "")
    }
}
