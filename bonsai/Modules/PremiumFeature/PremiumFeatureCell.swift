//
//  PremiumFeatureCell.swift
//  bonsai
//
//  Created by antuan.khoanh on 16/09/2022.
//

import SwiftUI

struct PremiumFeatureCell: View {
    
    private let premium: Premium
    
    private var isSelected: Bool = false
    
    init(premium: Premium) {
        self.premium = premium
    }
    
    var body: some View {
        HStack {
            Image(Asset.accountBalanceWallet.name)
                .padding(.bottom, 18)
                .padding([.trailing], 10)
            
            VStack(alignment: .leading) {
                Text(premium.name)
                    .font(.system(size: 17))
                    .bold()
                Text(premium.description)
                    .font(.system(size: 14))
                Rectangle()
                    .frame(height: 1)
            }
            BonsaiImage.chevronForward
                .renderingMode(.template)
                .foregroundColor(Color.white)
        }
    }

}

struct PremiumFeatureCell_Previews: PreviewProvider {
    static var previews: some View {
        PremiumFeatureCell(premium: mockPremiums.first!)
    }
}

struct Premium {
    let name: String
    let description: String
    let icon: String
}

let mockPremiums: [Premium] = [
    .init(name: "Unlimeted transactions", description: "You can create unlimeted transactions, You can create unlimeted transactions, You can create unlimeted transactions", icon: ""),
    .init(name: "Flexible budget", description: "Set flexible period days for budget,Set flexible period days for budget, Set flexible period days for budget", icon: ""),
    .init(name: "Unlimited budget", description: "Create unlimited budget for your needs, Create unlimited budget for your needs", icon: ""),
    .init(name: "Customize app", description: "Customize home background with your favourite tree, change icon of the app", icon: "")
]
