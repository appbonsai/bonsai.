//
//  MockDataTransactions.swift
//  bonsai
//
//  Created by hoang on 18.12.2021.
//

import Foundation

public struct MockDataTransaction {
   public static let viewContext = DataController.sharedInstance.container.viewContext

   public static let transactions = [
      Transaction(context: Self.viewContext,
                  amount: 20.0,
                  date: .from(year: 2021, month: 12, day: 17),
                  category: .init(
                     context: viewContext,
                     title: "Restaurant",
                     color: .green,
                     icon: .star),
                  account: .init(
                     context: viewContext,
                     title: "BonsaiTest"),
                  type: .expense,
                  tags: .init()),

      Transaction(context: Self.viewContext,
                  amount: 693.5,
                  date: .from(year: 2021, month: 12, day: 17),
                  category: .init(
                     context: viewContext,
                     title: "Fuel",
                     color: .blue,
                     icon: .fuel),
                  account: .init(
                     context: viewContext,
                     title: "BonsaiTest"),
                  type: .expense,
                  tags: .init()),

      Transaction(context: Self.viewContext,
                  amount: 776602.0,
                  date: .from(year: 2021, month: 8, day: 22),
                  category: .init(
                     context: viewContext,
                     title: "Graduation",
                     color: .red,
                     icon: .gameController),
                  account: .init(
                     context: viewContext,
                     title: "BonsaiTest"),
                  type: .expense,
                  tags: .init()),

      Transaction(context: Self.viewContext,
                  amount: 40.0,
                  date: .from(year: 2021, month: 12, day: 18),
                  category: .init(
                     context: viewContext,
                     title: "Salary",
                     color: .red,
                     icon: .heart),
                  account: .init(
                     context: viewContext,
                     title: "BonsaiTest"),
                  type: .income,
                  tags: .init())
   ]
}

