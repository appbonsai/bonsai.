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
            return "date.today"
        }
        if Calendar.current.isDateInYesterday(self) {
            return "date.yesterday"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }

    /*
     static func from(year: Int, month: Int, day: Int) -> Self
     Used only for mocking date
     */

    static func from(year: Int, month: Int, day: Int) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .autoupdatingCurrent
        calendar = dateFormatter.calendar
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? Date()
    }
}
