//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/26.
//

import UIKit

extension ReminderListViewController {
    // MARK: Internal Type Aliases

    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>

    // MARK: Internal Functions

    /// コレクションビューのセルに登録する内容のハンドラー
    /// - Parameters:
    ///   - cell: セル
    ///   - indexPath: インデックスパス
    ///   - id: ID
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration

        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .systemMint
        cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]

        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .systemBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }

    // MARK: Private Functions

    /// セルのアクセサリーの DONE ボタンのカスタム設定
    /// - Parameter reminder: モデル
    /// - Returns: セルのアクセサリーのカスタムビューの設定
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
