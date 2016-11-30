//
//  UIView+Constraints.swift
//  CleanCodeDemo
//
//  Created by Hervé Bérenger on 24/06/2016.
//
//

import Foundation

extension UIView {

    /**
     * Add view to itself, pinning edges to margins
     */

    public func ad_addSubview(_ view: UIView, withMargins margins: UIEdgeInsets) {
        let viewBindings = ["view" : view]
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)

        let metrics = ["top" : margins.top, "right" : margins.right, "bottom" : margins.bottom, "left" : margins.left]
        let hConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-left-[view]-right-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: metrics, views: viewBindings
        )

        let vConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-top-[view]-bottom-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: metrics, views: viewBindings
        )
        self.addConstraints(hConstraints)
        self.addConstraints(vConstraints)
    }
}
