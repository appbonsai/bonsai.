//
//  TreeState.swift
//  bonsai
//
//  Created by antuan.khoanh on 12/10/2022.
//

import Foundation
import SwiftUI

class TreeService: ObservableObject {
    
   enum TreeState {
      case excellent
      case good
      case normal
      case dying
   }
   
   let mockExcellentTree: [Image] = []
   let mockGoodTree: [Image] = []
   let mockNormalTree: [Image] = []
   let mockDyingTree: [Image] = []
   
   func updateTree(with state: TreeState) -> [Image] {
      switch state {
      case .excellent:
         return mockExcellentTree
      case .good:
         return mockGoodTree
      case .normal:
         return mockNormalTree
      case .dying:
         return mockDyingTree
      }
   }
}

