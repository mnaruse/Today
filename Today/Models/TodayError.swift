//
//  TodayError.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/10.
//

import Foundation

enum TodayError: LocalizedError {
    case accessDenied
    case failedReadingReminders
    case reminderHasNoDueDate

    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return L10n.Error.accessDenied
        case .failedReadingReminders:
            return L10n.Error.failedReadingReminders
        case .reminderHasNoDueDate:
            return L10n.Error.reminderHasNoDueDate
        }
    }
}
