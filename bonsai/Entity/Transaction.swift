//
//  Transaction.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//

import Foundation

struct Transaction: Identifiable {
    let id: UUID

    let type: `Type`
    let account: Account
    let amount: Double
    let title: String?
    let category: Category
    let tags: [Tag]
    let date: Date
}

extension Transaction {
    enum `Type` {
        case income
        case expense
        case transfer(toAccount: Account)
    }
}
