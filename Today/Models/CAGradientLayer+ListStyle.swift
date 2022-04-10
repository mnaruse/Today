//
//  CAGradientLayer+ListStyle.swift
//  Today
//
//  Created by Miharu Naruse on 2022/04/10.
//

import UIKit

extension CAGradientLayer {
    // MARK: Internal Static Functions

    static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer
    }

    // MARK: Private Static Functions

    private static func colors(for style: ReminderListStyle) -> [CGColor] {
        let beginColor: UIColor
        let endColor: UIColor

        switch style {
        case .today:
            beginColor = Asset.todayGradientTodayBegin.color
            endColor = Asset.todayGradientTodayEnd.color
        case .future:
            beginColor = Asset.todayGradientFutureBegin.color
            endColor = Asset.todayGradientFutureEnd.color
        case .all:
            beginColor = Asset.todayGradientAllBegin.color
            endColor = Asset.todayGradientAllEnd.color
        }

        return [beginColor.cgColor, endColor.cgColor]
    }
}
