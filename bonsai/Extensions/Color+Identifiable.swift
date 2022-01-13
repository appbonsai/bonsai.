//
//  Color+Identifiable.swift
//  bonsai
//
//  Created by Vladimir Korolev on 14.01.2022.
//

import SwiftUI

extension Color: Identifiable {
   public var id: String { description }
}
