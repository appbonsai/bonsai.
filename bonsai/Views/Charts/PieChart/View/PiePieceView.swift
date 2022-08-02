//
//  PiePieceView.swift
//  bonsai
//
//  Created by Максим Алексеев  on 14.07.2022.
//

import SwiftUI

struct PiePieceView: View {
    var center: CGPoint
    var radius: CGFloat
    var startDegree: Double
    var endDegree: Double
    var isTouched: Bool
    var accentColor: Color
    var disabledColor: Color
    
    var path: Path {
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree), clockwise: false)
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
    
    var body: some View {
        path
            .fill(isTouched ? accentColor : disabledColor)
            .overlay(path.stroke(BonsaiColor.card, lineWidth: isTouched ? 5 : 0))
            .scaleEffect(isTouched ? 1.1 : 1)
            .animation(.spring(), value: isTouched)
    }
}

struct PiePiece_Previews: PreviewProvider {
    static var previews: some View {
        PiePieceView(center: CGPoint(x: 100, y: 200), radius: 200, startDegree: 30, endDegree: 80, isTouched: false, accentColor: BonsaiColor.mainPurple, disabledColor: BonsaiColor.ChartDisabledColors.c1)
    }
} 
