//
//  UITableViewHeaderFooterView+PreferredLayoutHeight.swift
//  ADUtils
//
//  Created by Denis Poifol on 05/04/2019.
//

import Foundation
import UIKit

extension UITableViewHeaderFooterView {

    /**
     Provides the preferred layout height for the table view headerFooter, this is the smallest height the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingWidth: The biggest width the view can get

     - parameter computationType: The layout computation type to use
     */
    public func ad_preferredContentViewLayoutHeight(fittingWidth: CGFloat,
                                                    computationType: LayoutComputationType = .layoutEngine) -> CGFloat {
        switch computationType {
        case .autoLayout:
            return ad_autoLayoutHeaderFooterLayoutHeight(fittingWidth: fittingWidth)
        case .layoutEngine:
            let size = contentView.ad_preferredLayoutSize(fittingWidth: fittingWidth, computationType: computationType)
            return size.height
        }
    }

    // MARK: - Private

    /**
    Provides the preferred layout height for the table view headerFooter using autoLayout computation type,
    this is the smallest height the view and its content can fit. You should populate the view before calling this method.

    - parameter fittingWidth: The biggest width the view can get
    */
    private func ad_autoLayoutHeaderFooterLayoutHeight(fittingWidth: CGFloat) -> CGFloat {
        var bounds = self.bounds
        bounds.size.width = fittingWidth
        self.bounds = bounds
        let views = ["contentView": contentView]
        let visualFormats = ["H:|[contentView]|", "V:|[contentView]|"]
        let constraints = visualFormats
            .map {
                NSLayoutConstraint.constraints(
                    withVisualFormat: $0,
                    options: [],
                    metrics: nil,
                    views: views
                )
            }
            .flatMap { $0 }
        addConstraints(constraints)
        let height = contentView.ad_preferredLayoutHeight(fittingWidth: fittingWidth)
        removeConstraints(constraints)
        return height
    }
}
