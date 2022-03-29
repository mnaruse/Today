//
//  Date+Today.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/26.
//

import Foundation

extension Date {
    /// 日付と時刻のテキスト
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateFormat, dateText, timeText)
        }
    }

    /// 日付のテキスト
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date description")
        } else {
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
