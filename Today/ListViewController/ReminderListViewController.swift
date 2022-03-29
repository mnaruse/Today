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

        updateSnapShot()

        collectionView.dataSource = dataSource
    }

    // MARK: Private Functions

    /// コレクションビューの構成的なレイアウトとして、リストレイアウトを設定
    /// - Returns: コレクションビューの構成的なレイアウト
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
