//
//  TextFieldContentView.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/01.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {
    // MARK: Internal Structs

    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        /// ユーザーがテキストフィールドのテキストを編集したときに実行したい動作を保持
        var onChange: (String) -> Void = { _ in }

        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }

    // MARK: Internal Stored Properties

    let textField = UITextField()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    // MARK: Initializers

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        textField.clearButtonMode = .whileEditing
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 44)
    }

    // MARK: Internal Functions

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else {
            return
        }
        textField.text = configuration.text
    }

    @objc func didChange(_ sender: UITextField) {
        guard let configuration = configuration as? TextFieldContentView.Configuration else {
            return
        }
        configuration.onChange(textField.text ?? "")
    }
}

// MARK: - Extension UICollectionViewListCell

extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        TextFieldContentView.Configuration()
    }
}
