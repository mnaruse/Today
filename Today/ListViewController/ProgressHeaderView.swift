//
//  ProgressHeaderView.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/09.
//

import UIKit

class ProgressHeaderView: UICollectionReusableView {
    // MARK: Internal Static Computed Properties

    static var elementKind: String {
        return UICollectionView.elementKindSectionHeader
    }

    // MARK: Internal Stored Properties

    var progress: CGFloat = 0 {
        didSet {
            heightConstraint?.constant = progress * bounds.height
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }

    // MARK: Private Stored Properties

    private let upperView = UIView(frame: .zero)
    private let lowerView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private var heightConstraint: NSLayoutConstraint?

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 0.5 * containerView.bounds.width
    }

    // MARK: Private Functions

    private func prepareSubviews() {
        containerView.addSubview(upperView)
        containerView.addSubview(lowerView)
        addSubview(containerView)

        // 制約
        upperView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true

        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true

        upperView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        upperView.bottomAnchor.constraint(equalTo: lowerView.topAnchor).isActive = true
        lowerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        upperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        upperView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lowerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lowerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        heightConstraint = lowerView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true

        // 配色
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        upperView.backgroundColor = Asset.todayProgressUpperBackground.color
        lowerView.backgroundColor = Asset.todayProgressLowerBackground.color
    }
}
