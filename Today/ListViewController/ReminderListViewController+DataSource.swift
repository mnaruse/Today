//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/26.
//

import UIKit

extension ReminderListViewController {
    // MARK: Internal Type Aliases

    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>

    // MARK: Private Computed Properties

    var reminderCompletedValue: String {
        L10n.Accessibility.completed
    }

    var reminderNotCompletedValue: String {
        L10n.Accessibility.notCompleted
    }

    // MARK: Internal Functions

    /// 新しい Reminder を追加
    /// - Parameter reminder: 新しい Reminder
    func add(_ reminder: Reminder) {
        reminders.append(reminder)
    }

    /// インデックスを元に Reminder を取得
    /// - Parameter id: インデックス
    /// - Returns: Reminder
    func reminder(for id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(with: id)
        return reminders[index]
    }

    /// 新しい Reminder とインデックスを元に、Reminder を更新
    /// - Parameters:
    ///   - reminder: 新しい Reminder
    ///   - id: インデックス
    func update(_ reminder: Reminder, with id: Reminder.ID) {
        let index = reminders.indexOfReminder(with: id)
        reminders[index] = reminder
    }

    /// 特定の ID の Reminder を削除
    /// - Parameter id: 削除したい Reminder の ID
    func deleteReminder(with id: Reminder.ID) {
        let index = reminders.indexOfReminder(with: id)
        reminders.remove(at: index)
    }

    /// スナップショットを更新
    /// - Parameter ids: 更新したい Reminder の ID の配列
    func updateSnapShot(reloading idsThatChanged: [Reminder.ID] = []) {
        let ids = idsThatChanged.filter { id in
            filteredReminders.contains(where: { $0.id == id })
        }
        var snapShot = SnapShot()
        snapShot.appendSections([0])
        snapShot.appendItems(filteredReminders.map { $0.id })
        if !ids.isEmpty {
            snapShot.reloadItems(ids)
        }
        dataSource.apply(snapShot)
        headerView?.progress = progress
    }

    /// コレクションビューのセルに登録する内容のハンドラー
    /// - Parameters:
    ///   - cell: セル
    ///   - indexPath: インデックスパス
    ///   - id: ID
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = reminder(for: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration

        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = Asset.todayListCellDoneButtonTint.color
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]

        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = Asset.todayListCellBackground.color
        cell.backgroundConfiguration = backgroundConfiguration
    }

    /// Reminder の完了状態を切替
    /// - Parameter id: ID
    func completeReminder(with id: Reminder.ID) {
        var reminder = reminder(for: id)
        reminder.isComplete.toggle()
        update(reminder, with: id)
        updateSnapShot(reloading: [id])
    }

    // MARK: Private Functions

    /// セルのアクセサリーの DONE ボタンのアクセシビリティアクション
    /// - Parameter reminder: モデル
    /// - Returns: アクセシビリティアクション
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = L10n.Accessibility.toggleCompletion
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(with: reminder.id)
            return true
        }
        return action
    }

    /// セルのアクセサリーの DONE ボタンのカスタム設定
    /// - Parameter reminder: モデル
    /// - Returns: セルのアクセサリーのカスタムビューの設定
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
