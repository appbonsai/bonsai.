//
//  NavigationBackButton.swift
//  bonsai
//
//  Created by Vladimir Korolev on 19.01.2022.
//

import SwiftUI

struct NavigationBackButton: View {
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        Button(action: {
            isPresented = false
        }) {
            HStack(spacing: 12) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(BonsaiColor.secondary)
                Text(L.backTitle)
                    .foregroundColor(BonsaiColor.secondary)
            }
        }
    }
}

struct NavigationBackButton_Previews: PreviewProvider {
   static var previews: some View {
      NavigationBackButton(isPresented: .constant(true))
   }
}
