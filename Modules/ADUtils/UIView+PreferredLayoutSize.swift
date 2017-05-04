//
//  UIView+PreferredLayoutSize.swift
//  Pods
//
//  Created by Benjamin Lavialle on 04/05/2017.
//
//

import Foundation

public extension UIView {

    /**
     Provides the preferred layout size for the view, this is the smallest size the view and its content can fit. You should populate the view before calling this method.

     - parameter targetSize: The biggest size the view can get

     - parameter lockWidth: Defines if the view's width should be locked while getting the size
     */
    public func ad_preferredLayoutSize(
        fittingSize targetSize: CGSize,
        lockWidth: Bool = false
        ) -> CGSize {
        let previousTranslatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        translatesAutoresizingMaskIntoConstraints = false
        var widthConstraints: [NSLayoutConstraint]?
        if lockWidth {
            widthConstraints = self.lockView(to: targetSize.width)
        }
        layoutIfNeeded()

        let height = ceil(systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)
        if let widthConstraints = widthConstraints {
            self.removeConstraints(widthConstraints)
        }
        translatesAutoresizingMaskIntoConstraints = previousTranslatesAutoresizingMaskIntoConstraints
        return CGSize(width: targetSize.width, height: height)
    }

    //MARK: - Private

    private func lockView(to maximalWidth: CGFloat) -> [NSLayoutConstraint] {
        let equalConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: maximalWidth
        )
        //???: (Benjamin Lavialle) 2017-05-04 Do not use required in case there is an other width constraint
        equalConstraint.priority = UILayoutPriorityRequired - 1
        let maxConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .lessThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: maximalWidth
        )
        maxConstraint.priority = UILayoutPriorityRequired
        let constraints = [equalConstraint, maxConstraint]
        addConstraints(constraints)
        return constraints
    }
}
