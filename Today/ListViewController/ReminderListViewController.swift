//
//  ReminderListViewController.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/25.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    // MARK: Internal Properties

    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData
    var filteredReminders: [Reminder] {
        return reminders
            .filter { listStyle.shouldInclude(date: $0.dueDate) }
            .sorted(by: { $0.dueDate < $1.dueDate })
    }

    var listStyle: ReminderListStyle = .today
    var listStyleSegmentedControl = UISegmentedControl(items: [
        ReminderListStyle.today.name,
        ReminderListStyle.future.name,
        ReminderListStyle.all.name
    ])
    var headerView: ProgressHeaderView?
    var progress: CGFloat {
        let chunkSize = 1.0 / CGFloat(filteredReminders.count)
        let progress = filteredReminders.reduce(0.0) {
            let chunk = $1.isComplete ? chunkSize : 0.0
            return $0 + chunk
        }
        return progress
    }

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = Asset.todayGradientFutureBegin.color

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ProgressHeaderView.elementKind, handler: supplementaryRegistrationHandler)
        dataSource.supplementaryViewProvider = { [weak self] (supplementaryView: UICollectionView, elementKind: String, indexPath: IndexPath) in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = L10n.Accessibility.addReminder
        navigationItem.rightBarButtonItem = addButton

        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        listStyleSegmentedControl.addTarget(self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        navigationItem.titleView = listStyleSegmentedControl

        updateSnapShot()

        collectionView.dataSource = dataSource
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = filteredReminders[indexPath.item].id
        showDetail(for: id)
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == ProgressHeaderView.elementKind, let progressView = view as? ProgressHeaderView else {
            return
        }
        progressView.progress = progress
    }

    // MARK: Private Functions

    /// コレクションビューの構成的なレイアウトとして、リストレイアウトを設定
    /// - Returns: コレクションビューの構成的なレイアウト
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    /// Reminder の詳細を表示
    /// - Parameter id: ID
    private func showDetail(for id: Reminder.ID) {
        let reminder = reminder(for: id)
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
            self?.update(reminder, with: reminder.id)
            self?.updateSnapShot(reloading: [reminder.id])
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        let deleteActionTitle = L10n.Action.delete
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
            self?.deleteReminder(with: id)
            self?.updateSnapShot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func supplementaryRegistrationHandler(progressView: ProgressHeaderView, elementKind: String, indexPath: IndexPath) {
        headerView = progressView
    }
}
