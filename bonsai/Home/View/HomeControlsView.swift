//
//  HomeControls.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

struct HomeControlsView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(uiImage: #imageLiteral(resourceName: "settings"))
            Spacer(minLength: 100)
            Image(uiImage: #imageLiteral(resourceName: "home"))
            Spacer(minLength: 100)
            Image(uiImage: #imageLiteral(resourceName: "charts"))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 36.0)
    }
}

struct HomeControlsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeControlsView()
    }
}
