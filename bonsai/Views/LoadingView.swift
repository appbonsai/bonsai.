//
//  LoadingView.swift
//  bonsai
//
//  Created by antuan.khoanh on 10/09/2022.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                Spinner()
                    .opacity(isShowing ? 1 : 0)
            }
        }
    }

}


struct LoadingAllSet<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                Spinner()
                    .opacity(isShowing ? 1 : 0)
                
                AllSet()
                    .offset(y: isShowing ?
                            0 :
                             UIScreen.main.bounds.height)
                    .animation(
                     .interpolatingSpring(
                         mass: 1,
                         stiffness: 50,
                         damping: 10,
                         initialVelocity: 0
                     ))
            }
        }
    }

}
