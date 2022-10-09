//
//  NewOperationView+OperationType.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11.12.2021.
//

import SwiftUI

extension NewOperationView {
   enum OperationType {
      case expense
      case income
      case transfer

      init(transactionType: Transaction.`Type`) {
         switch transactionType {
         case .income:
            self = .income
         case .expense:
            self = .expense
         case .transfer(let _):
            assertionFailure("Unexpected branch, transfer is not supported yet")
            self = .transfer
         }
      }
   }
}

extension NewOperationView.OperationType {
   struct ViewModel {
      let color: Color
      let image: Image
      let title: String
   }

   var viewModel: ViewModel {
      switch self {
      case .expense:
         return .init(
            color: BonsaiColor.secondary,
            image: Image(uiImage: Asset.trendingDown.image),
            title: "Expense"
         )
      case .income:
         return .init(
            color: BonsaiColor.green,
            image: Image(uiImage: Asset.trendingUp.image),
            title: "Revenue"
         )
      case .transfer:
         return .init(
            color: BonsaiColor.blue,
            image: Image(uiImage: Asset.trendingFlat.image),
            title: "Transfer"
         )
      }
   }

   var mappedToTransactionType: Transaction.`Type` {
      switch self {
      case .expense:
         return .expense
      case .income:
         return .income
      case .transfer:
         assertionFailure("Unexpected branch, transfer is not supported yet")
         return .expense
      }
   }
}
