//
//  StackViewBuilder.swift
//  ADUtils
//
//  Created by Pierre Felgines on 17/03/2021.
//

import UIKit

@resultBuilder
public struct UIViewBuilder { // swiftlint:disable:this convenience_type

    public static func buildBlock(_ views: UIView...) -> [UIView] {
        Array(views)
    }
}

/**
 * Creates a horizontal stackView
 * - parameter spacing: The distance in points between the adjacent edges of the stack view’s arranged views.
 * - parameter alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis.
 * - parameter distribution: The distribution of the arranged views along the stack view’s axis.
 * - parameter arrangedSubviews: The view builder for arranged subviews
 */
@MainActor
public func HStackView(spacing: CGFloat = 0,
                       alignment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       @UIViewBuilder arrangedSubviews: () -> [UIView]) -> UIStackView {
    let view = UIStackView(arrangedSubviews: arrangedSubviews())
    view.spacing = spacing
    view.axis = .horizontal
    view.distribution = distribution
    view.alignment = alignment
    return view
}

/**
 * Creates a vertical stackView
 * - parameter spacing: The distance in points between the adjacent edges of the stack view’s arranged views.
 * - parameter alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis.
 * - parameter distribution: The distribution of the arranged views along the stack view’s axis.
 * - parameter arrangedSubviews: The view builder for arranged subviews
 */
@MainActor
public func VStackView(spacing: CGFloat = 0,
                       alignment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       @UIViewBuilder arrangedSubviews: () -> [UIView]) -> UIStackView {
    let view = UIStackView(arrangedSubviews: arrangedSubviews())
    view.spacing = spacing
    view.axis = .vertical
    view.distribution = distribution
    view.alignment = alignment
    return view
}
