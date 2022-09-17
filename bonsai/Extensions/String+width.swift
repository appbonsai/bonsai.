//
//  String+width.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/09/2022.
//

import Foundation
import UIKit

extension String {
    func widthOfString(usingFont font: UIFont, inset: CGFloat) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width + inset
    }
}
