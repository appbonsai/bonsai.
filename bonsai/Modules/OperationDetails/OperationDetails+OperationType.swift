//
//  OperationDetails+OperationType.swift
//  bonsai
//
//  Created by Vladimir Korolev on 11.12.2021.
//

import SwiftUI

extension OperationDetails {

    enum OperationType: String {
        case expense
        case income
        case transfer

        init(transactionType: Transaction.`Type`) {
            switch transactionType {
            case .income:
                self = .income
            case .expense:
                self = .expense
            case .transfer:
                assertionFailure("Unexpected branch, transfer is not supported yet")
                self = .transfer
            }
        }
    }
}

extension OperationDetails.OperationType {
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
                image: Image(Asset.trendingDown.name),
                title: L.Operation.expense
            )
        case .income:
            return .init(
                color: BonsaiColor.green,
                image: Image(Asset.trendingUp.name),
                title: L.Operation.income
            )
        case .transfer:
            return .init(
                color: BonsaiColor.blue,
                image: Image(Asset.trendingFlat.name),
                title: L.Operation.transfer
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
