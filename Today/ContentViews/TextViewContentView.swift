//
//  TextViewContentView.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/02.
//

import UIKit

class TextViewContentView: UIView, UIContentView {
    // MARK: Internal Structs

    struct Configuration: UIContentConfiguration {
        var text: String?
        /// ユーザーがテキストビューのテキストを編集したときに実行したい動作を保持
        var onChange: (String) -> Void = { _ in }

        func makeContentView() -> UIView & UIContentView {
            TextViewContentView(self)
        }
    }

    // MARK: Internal Stored Properties

    let textView = UITextView()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    // MARK: Initializers

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textView, height: 200)
        textView.backgroundColor = nil
        textView.delegate = self
        textView.font = UIFont.preferredFont(forTextStyle: .body)
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
        textView.text = configuration.text
    }
}

// MARK: - Extensions UICollectionViewListCell

extension UICollectionViewListCell {
    func textViewConfiguraion() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}

// MARK: - Extensions UITextViewDelegate

extension TextViewContentView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let configuration = configuration as? TextViewContentView.Configuration else {
            return
        }
        configuration.onChange(textView.text)
    }
}
