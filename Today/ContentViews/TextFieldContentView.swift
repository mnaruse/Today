//
//  TextFieldContentView.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/01.
//

import UIKit

class TextFieldContentView: UIView {
    // MARK: Internal Stored Properties

    let textField = UITextField()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
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
}
