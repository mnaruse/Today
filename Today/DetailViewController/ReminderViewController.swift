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

    // MARK: Internal Stored Properties

    var reminder: Reminder {
        didSet {
            onChange(reminder)
        }
    }

    /// 一時的な Reminder
    ///
    /// ユーザーが保存または破棄を選択するまで、編集内容を保存する。
    var workingReminder: Reminder
    /// 新しい Reminder を追加しているか、既存のものを閲覧、編集しているか
    ///
    /// `true` : 新しい Reminder を追加している
    /// `false` : 既存のものを閲覧、編集している
    var isAddingNewReminder = false
    /// Reminder の値が変更されたときに実行したい動作を保持
    var onChange: (Reminder) -> Void

    // MARK: Private Stored Properties

    private var dataSource: DataSource!

    // MARK: Initializers

    init(reminder: Reminder, onChange: @escaping (Reminder) -> Void) {
        self.reminder = reminder
        workingReminder = reminder
        self.onChange = onChange
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
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

        navigationItem.title = L10n.Title.viewAndEditReminder
        navigationItem.rightBarButtonItem = editButtonItem

        updateSnapShotForViewing()

        collectionView.dataSource = dataSource
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing {
            prepareForEditing()
        } else {
            if isAddingNewReminder {
                onChange(workingReminder)
            } else {
                prepareForViewing()
            }
        }
    }

    // MARK: Private Functions

    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case let (_, .header(title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case let (.title, .editText(title)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case let (.date, .editDate(date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case let (.notes, .editText(notes)):
            cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
        default:
            fatalError("Unexpected combination of section and row.")
        }

        cell.tintColor = Asset.todayPrimaryTint.color
    }

    @objc private func didCancelEdit() {
        workingReminder = reminder
        setEditing(false, animated: true)
    }

    /// 編集モードを準備
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
        updateSnapshotForEditing()
    }

    /// 編集モードのスナップショットを更新
    private func updateSnapshotForEditing() {
        var snapShot = SnapShot()
        snapShot.appendSections([.title, .date, .notes])
        snapShot.appendItems([.header(Section.title.name), .editText(reminder.title)], toSection: .title)
        snapShot.appendItems([.header(Section.date.name), .editDate(reminder.dueDate)], toSection: .date)
        snapShot.appendItems([.header(Section.notes.name), .editText(reminder.notes)], toSection: .notes)
        dataSource.apply(snapShot)
    }

    /// 閲覧モードを準備
    private func prepareForViewing() {
        navigationItem.leftBarButtonItem = nil
        if workingReminder != reminder {
            reminder = workingReminder
        }
        updateSnapShotForViewing()
    }

    /// 閲覧モードのスナップショットを更新
    private func updateSnapShotForViewing() {
        var snapShot = SnapShot()
        snapShot.appendSections([.view])
        snapShot.appendItems([.header(""), .viewTitle, .viewDate, .viewTime, .viewNotes], toSection: .view)
        dataSource.apply(snapShot)
    }

    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
