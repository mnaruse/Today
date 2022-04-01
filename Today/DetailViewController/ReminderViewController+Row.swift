//
//  ReminderViewController+Row.swift
//  Today
//
//  Created by Miharu Naruse on 2022/03/30.
//

import UIKit

extension ReminderViewController {
    // MARK: Internal Enums

    enum Row: Hashable {
        case viewDate
        case viewNotes
        case viewTime
        case viewTitle

        // MARK: Internal Computed Properties

        var image: UIImage? {
            guard let imageName = imageName else {
                return nil
            }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }

        var textStyle: UIFont.TextStyle {
            switch self {
            case .viewTitle:
                return .headline
            default:
                return .subheadline
            }
        }

        // MARK: Private Computed Properties

        private var imageName: String? {
            switch self {
            case .viewDate:
                return "calendar.circle"
            case .viewNotes:
                return "square.and.pencil"
            case .viewTime:
                return "clock"
            default:
                return nil
            }
        }
    }
}
