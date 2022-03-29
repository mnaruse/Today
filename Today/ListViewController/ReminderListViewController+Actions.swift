//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/29.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else {
            return
        }
        completeReminder(with: id)
    }
}
