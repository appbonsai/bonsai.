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
      static let green = 76...100
      static let orange = 56...75
      static let yellow = 21...55
      static let brown = 0...20
   }
   
   let mockExcellentTree: [Image] = []
   let mockGoodTree: [Image] = []
   let mockNormalTree: [Image] = []
   let mockDyingTree: [Image] = []
   
   func updateTree(with percent: Int) -> [Image] {
      
      /*
       взять Изначальную сумму дейли от полной суммы бюджета
       потом взять текущую и разделить на Изначальную
       
       если этот процент входит в ТрееСтейт то возвращать дерево
       
       */
      
      switch percent {
      case(TreeState.green):
         return []
      case(TreeState.orange):
         return []
      case(TreeState.yellow):
         return []
      case(TreeState.brown):
         return []
      default: return []
      }
      
//      switch state {
//      case .green:
//         return mockExcellentTree
//      case .orange:
//         return mockGoodTree
//      case .yellow:
//         return mockNormalTree
//      case .brown:
//         return mockDyingTree
//      }
   }
}

