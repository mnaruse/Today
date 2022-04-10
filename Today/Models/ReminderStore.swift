//
//  ReminderStore.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/10.
//

import EventKit
import Foundation

class ReminderStore {
    static let shared = ReminderStore()

    private let ekStore = EKEventStore()

    var isAvailable: Bool {
        return EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
}
