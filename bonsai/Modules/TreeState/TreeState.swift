//
//  TreeState.swift
//  bonsai
//
//  Created by antuan.khoanh on 12/10/2022.
//

import Foundation
import SwiftUI

class TreeService: ObservableObject {
   
   let mockExcellentTree: [Image] = []
   let mockGoodTree: [Image] = []
   let mockNormalTree: [Image] = []
   let mockDyingTree: [Image] = []
   
   func updateTree(with percent: NSDecimalNumber) -> [Image] {
      switch percent {
      case 76...100:
         return mockExcellentTree
      case 56...75:
         return mockGoodTree
      case 21...55:
         return mockNormalTree
      case 0...20:
         return mockDyingTree
      default: return mockDyingTree
      }
   }
}

