//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/01.
//

import UIKit

extension ReminderViewController {
    enum Section: Int, Hashable {
        case view
        case title
        case date
        case notes

        var name: String {
            switch self {
            case .view:
                return ""
            case .title:
                return L10n.Reminder.Section.title
            case .date:
                return L10n.Reminder.Section.date
            case .notes:
                return L10n.Reminder.Section.notes
            }
        }
    }
}
