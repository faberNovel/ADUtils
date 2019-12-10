//
//  UIView+PreferredLayoutSize.swift
//  Pods
//
//  Created by Benjamin Lavialle on 04/05/2017.
//
//

import Foundation
import UIKit

private enum LayoutOrientation {
    case horizontal
    case vertical
}

public extension UIView {

    /**
     Provides the preferred layout height for the view, this is the smallest height the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingWidth: The biggest width the view can get
     */
    func ad_preferredLayoutHeight(fittingWidth: CGFloat) -> CGFloat {
        return ad_preferredLayoutSize(
            fittingSize: CGSize(width: fittingWidth, height: 0),
            lockDirection: .horizontal
        ).height
    }

    /**
     Provides the preferred layout width for the view, this is the smallest width the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingHeight: The biggest height the view can get
     */
    func ad_preferredLayoutWidth(fittingHeight: CGFloat) -> CGFloat {
        return ad_preferredLayoutSize(
            fittingSize: CGSize(width: 0, height: fittingHeight),
            lockDirection: .vertical
        ).width
    }

    // MARK: - Private

    /**
     Provides the preferred layout size for the view, this is the smallest size the view and its content can fit. You should populate the view before calling this method.

     - parameter targetSize: The biggest size the view can get

     - parameter lockDirection: Defines if the view's direction that should be locked while getting the size
     */
    private func ad_preferredLayoutSize(fittingSize targetSize: CGSize,
                                        lockDirection: LayoutOrientation) -> CGSize {
        let previousTranslatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        translatesAutoresizingMaskIntoConstraints = false
        var lockConstraints: [NSLayoutConstraint] = []
        switch lockDirection {
        case .horizontal:
            lockConstraints.append(contentsOf: lockView(.width, to:targetSize.width))
        case .vertical:
            // TODO: (Pierre Felgines) 18/04/2018 Someone with a real life test case should handle the layout
            NSLog("[ADUtils] WARNING, argument LayoutOrientation.vertical is not handled yet...")
            lockConstraints.append(contentsOf: lockView(.height, to:targetSize.height))
        }
        layoutIfNeeded()
        let computedSize = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.removeConstraints(lockConstraints)
        translatesAutoresizingMaskIntoConstraints = previousTranslatesAutoresizingMaskIntoConstraints
        return CGSize(
            width: ceil(computedSize.width),
            height: ceil(computedSize.height)
        )
    }

    private func lockView(_ attribute: NSLayoutConstraint.Attribute, to value: CGFloat) -> [NSLayoutConstraint] {
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
