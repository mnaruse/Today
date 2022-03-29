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
            return L10n.todayAtTime(timeText)
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            return L10n.dateAtTime(dateText, timeText)
        }
    }

    /// 日付のテキスト
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return L10n.today
        } else {
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
