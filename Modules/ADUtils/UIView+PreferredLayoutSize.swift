//
//  UIView+PreferredLayoutSize.swift
//  Pods
//
//  Created by Benjamin Lavialle on 04/05/2017.
//
//

import Foundation

public struct LayoutOrientation: OptionSet {

    public let rawValue: Int

    public init(rawValue: Int) { self.rawValue = rawValue }

    public static let horizontal = LayoutOrientation(rawValue: 1 << 0)
    public static let vertical = LayoutOrientation(rawValue: 1 << 1)
}

public extension UIView {

    /**
     Provides the preferred layout size for the view, this is the smallest size the view and its content can fit. You should populate the view before calling this method.

     - parameter targetSize: The biggest size the view can get

     - parameter lockWidth: Defines if the view's width should be locked while getting the size
     */
    public func ad_preferredLayoutSize(
        fittingSize targetSize: CGSize,
        lockDirections: LayoutOrientation? = nil
        ) -> CGSize {
        let previousTranslatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        translatesAutoresizingMaskIntoConstraints = false
        var lockConstraints: [NSLayoutConstraint] = []
        if lockDirections?.contains(LayoutOrientation.horizontal) ?? false {
            lockConstraints.append(contentsOf: lockView(.width, to:targetSize.width))
        }
        if lockDirections?.contains(LayoutOrientation.vertical) ?? false {
            lockConstraints.append(contentsOf: lockView(.height, to:targetSize.height))
        }
        layoutIfNeeded()
        let height = ceil(systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)
        self.removeConstraints(lockConstraints)
        translatesAutoresizingMaskIntoConstraints = previousTranslatesAutoresizingMaskIntoConstraints
        return CGSize(width: targetSize.width, height: height)
    }

    //MARK: - Private

    private func lockView(_ attribute: NSLayoutAttribute, to value: CGFloat) -> [NSLayoutConstraint] {
        let equalConstraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: value
        )
        //???: (Benjamin Lavialle) 2017-05-04 Do not use required in case there is an other width constraint
        equalConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
        let maxConstraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .lessThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: value
        )
        maxConstraint.priority = UILayoutPriority.required
        let constraints = [equalConstraint, maxConstraint]
        addConstraints(constraints)
        return constraints
    }
}
