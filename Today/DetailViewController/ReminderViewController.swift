//
//  ReminderViewController.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/30.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    // MARK: Private Type Aliases

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Row>

    // MARK: Private Stored Properties

    private var reminder: Reminder
    private var dataSource: DataSource!

    // MARK: Initializers

    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)

        super.init(collectionViewLayout: listLayout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

        navigationItem.title = L10n.Title.reminderVC
        navigationItem.rightBarButtonItem = editButtonItem

        updateSnapShotForViewing()

        collectionView.dataSource = dataSource
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing {
            updateSnapshotForEditing()
        } else {
            updateSnapShotForViewing()
        }
    }

    // MARK: Private Functions

    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (.view, _):
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = text(for: row)
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
            contentConfiguration.image = row.image
            cell.contentConfiguration = contentConfiguration
        default:
            fatalError("Unexpected combination of section and row.")
        }

        cell.tintColor = Asset.todayPrimaryTint.color
    }

    /// 編集用のスナップショットを更新
    private func updateSnapshotForEditing() {
        var snapShot = SnapShot()
        snapShot.appendSections([.title, .date, .notes])
        dataSource.apply(snapShot)
    }

    /// 閲覧用のスナップショットを更新
    private func updateSnapShotForViewing() {
        var snapShot = SnapShot()
        snapShot.appendSections([.view])
        snapShot.appendItems([.viewTitle, .viewDate, .viewTime, .viewNotes], toSection: .view)
        dataSource.apply(snapShot)
    }

    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }

    private func text(for row: Row) -> String? {
        switch row {
        case .viewDate:
            return reminder.dueDate.dayText
        case .viewNotes:
            return reminder.notes
        case .viewTime:
            return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .viewTitle:
            return reminder.title
        }
    }
}
