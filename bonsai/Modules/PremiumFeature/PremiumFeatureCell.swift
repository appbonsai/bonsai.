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
        RoundedRectangle(cornerRadius: 8)
            .frame(height: 80)
            .foregroundColor(BonsaiColor.card)
            .overlay {
                HStack {
                   premium.icon
                        .padding([.leading ,.trailing], 10)
                    
                    Text(LocalizedStringKey(premium.name))
                        .font(.system(size: 17))
                        .bold()
                        .padding(.bottom, 2)
                    
                    Spacer()
                    BonsaiImage.chevronForward
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 18)
                }
            }
            .padding([.leading, .trailing], 12)
    }
    

}

struct PremiumFeatureCell_Previews: PreviewProvider {
    static var previews: some View {
       PremiumFeatureCell(premium: .init(name: "", description: "", icon: BonsaiImage.tag, gifImage: ""))
    }
}

struct Premium {
    let name: String
    let description: String
    let icon: Image
    let gifImage: String
}
