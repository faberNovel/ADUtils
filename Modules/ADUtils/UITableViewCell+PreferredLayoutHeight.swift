//
//  UITableViewCell+PreferredLayoutHeight.swift
//  ADUtils
//
//  Created by Pierre Felgines on 18/04/2018.
//

import Foundation

public extension UITableViewCell {

    /**
     Provides the preferred layout height for the table view cell, this is the smallest height the view and its content can fit. You should populate the view before calling this method.

     - parameter targetSize: The biggest size the view can get
     */
    public func ad_preferredLayoutHeight(fittingSize targetSize: CGSize) -> CGFloat {
        var bounds = self.bounds
        bounds.size.width = targetSize.width
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
        let size = contentView.ad_preferredLayoutSize(
            fittingSize: targetSize,
            lockDirections: [.horizontal]
        )
        removeConstraints(constraints)
        return size.height
    }
}
