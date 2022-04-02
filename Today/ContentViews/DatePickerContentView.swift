//
//  DatePickerContentView.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/02.
//

import UIKit

class DatePickerContentView: UIView, UIContentView {
    // MARK: Internal Structs

    struct Configuration: UIContentConfiguration {
        var date = Date.now

        func makeContentView() -> UIView & UIContentView {
            DatePickerContentView(self)
        }
    }

    // MARK: Internal Stored Properties

    let datePicker = UIDatePicker()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    // MARK: Initializers

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal Functions

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? DatePickerContentView.Configuration else {
            return
        }
        datePicker.date = configuration.date
    }
}

// MARK: - Extension UICollectionViewListCell

extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        return DatePickerContentView.Configuration()
    }
}
