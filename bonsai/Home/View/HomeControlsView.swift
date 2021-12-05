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
            Image(Asset.settings.name)
                .resizable()
                .frame(width: 20, height: 20)
            Spacer(minLength: 100)
            Image(Asset.home.name)
                .resizable()
                .frame(width: 27, height: 25)
            Spacer(minLength: 100)
            Image(Asset.charts.name)
                .resizable()
                .frame(width: 20, height: 20)
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
