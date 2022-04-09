//
//  ReminderListViewController.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/25.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    // MARK: Internal Properries

    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = L10n.Accessibility.addReminder
        navigationItem.rightBarButtonItem = addButton

        updateSnapShot()

        collectionView.dataSource = dataSource
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.item].id
        showDetail(for: id)
        return false
    }

    // MARK: Private Functions

    /// コレクションビューの構成的なレイアウトとして、リストレイアウトを設定
    /// - Returns: コレクションビューの構成的なレイアウト
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
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
}
