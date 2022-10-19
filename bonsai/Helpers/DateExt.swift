//
//  DateExt.swift
//  bonsai
//
//  Created by hoang on 12.12.2021.
//

import Foundation

extension Date {

   func dateString() -> String {
      if Calendar.current.isDateInToday(self) {
         return "Today"
      }
      if Calendar.current.isDateInYesterday(self) {
         return "Yesterday"
      }
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      return dateFormatter.string(from: self)
   }

   /*
    static func from(year: Int, month: Int, day: Int) -> Self
    Used only for mocking date
    */

   static func from(year: Int, month: Int, day: Int) -> Self {
      var dateComponents = DateComponents()
      dateComponents.year = year
      dateComponents.month = month
      dateComponents.day = day
      return Calendar.current.date(from: dateComponents)!
   }
}
