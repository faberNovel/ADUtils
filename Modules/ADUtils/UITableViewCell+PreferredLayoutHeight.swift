//
//  UITableViewCell+PreferredLayoutHeight.swift
//  ADUtils
//
//  Created by Pierre Felgines on 18/04/2018.
//

import Foundation
import UIKit

public extension UITableViewCell {

    /**
     Provides the preferred layout height for the table view cell, this is the smallest height the view and its content can fit. You should populate the view before calling this method.

     - parameter fittingWidth: The biggest width the view can get

     - parameter computationType: The layout computation type to use
     */
    func ad_preferredCellLayoutHeight(fittingWidth: CGFloat,
                                      computationType: LayoutComputationType = .layoutEngine) -> CGFloat {
        switch computationType {
        case .autoLayout:
            return ad_autoLayoutCellLayoutHeight(fittingWidth: fittingWidth)
        case .layoutEngine:
            let size = contentView.ad_preferredLayoutSize(fittingWidth: fittingWidth, computationType: computationType)
            return size.height
        }
    }

    // MARK: - Private

    /**
    Provides the preferred layout height for the table view cell using autoLayout computation type,
    this is the smallest height the view and its content can fit. You should populate the view before calling this method.

    - parameter fittingWidth: The biggest width the view can get
    */
    private func ad_autoLayoutCellLayoutHeight(fittingWidth: CGFloat) -> CGFloat {
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
        let height = contentView.ad_preferredLayoutSize(fittingWidth: fittingWidth, computationType: .autoLayout).height
        removeConstraints(constraints)
        return height
    }
}
