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
            fittingSize: CGSize(width: fittingWidth, height: UIView.layoutFittingCompressedSize.height),
            lockDirection: .horizontal
        ).height
    }

    /**
     Provides the preferred layout width for the view, this is the smallest width the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingHeight: The biggest height the view can get
     */
    func ad_preferredLayoutWidth(fittingHeight: CGFloat) -> CGFloat {
        return ad_preferredLayoutSize(
            fittingSize: CGSize(width: UIView.layoutFittingCompressedSize.width, height: fittingHeight),
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
        let horizontalFittingPriority: UILayoutPriority
        let verticalFittingPriority: UILayoutPriority
        switch lockDirection {
        case .horizontal:
            horizontalFittingPriority = .required
            verticalFittingPriority = .fittingSizeLevel
        case .vertical:
            horizontalFittingPriority = .fittingSizeLevel
            verticalFittingPriority = .required
        }
        let computedSize = systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontalFittingPriority,
            verticalFittingPriority: verticalFittingPriority
        )
        return CGSize(
            width: ceil(computedSize.width),
            height: ceil(computedSize.height)
        )
    }
}
