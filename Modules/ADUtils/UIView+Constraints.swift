//
//  UIView+Constraints.swift
//  CleanCodeDemo
//
//  Created by Hervé Bérenger on 24/06/2016.
//
//

import Foundation

typealias UIEdgeMargins = UIEdgeInsets

let UIEdgeMarginsZero = UIEdgeInsetsZero

extension UIView {

    /**
     * Add view to itself, pinning edges to margins
     */

    func ad_addSubview(view: UIView, withMargins margins: UIEdgeMargins) {
        let viewBindings = ["view" : view]
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)

        let metrics = ["top" : margins.top, "right" : margins.right, "bottom" : margins.bottom, "left" : margins.left]
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[view]-right-|",
                                                                         options: NSLayoutFormatOptions(rawValue:0),
                                                                         metrics: metrics, views: viewBindings)

        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[view]-bottom-|",
                                                                          options: NSLayoutFormatOptions(rawValue:0),
                                                                          metrics: metrics, views: viewBindings)
        self.addConstraints(hConstraints)
        self.addConstraints(vConstraints)
    }
}
