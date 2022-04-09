//
//  ReminderListStyle.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/09.
//

import UIKit

enum ReminderListStyle: Int, CaseIterable {
    case today
    case future
    case all

    var name: String {
        switch self {
        case .today:
            return L10n.Segment.today
        case .future:
            return L10n.Segment.future
        case .all:
            return L10n.Segment.all
        }
    }

    func shouldInclude(date: Date) -> Bool {
        let isInToday = Locale.current.calendar.isDateInToday(date)
        switch self {
        case .today:
            return isInToday
        case .future:
            return (date > Date.now) && !isInToday
        case .all:
            return true
        }
    }
}
