//
//  UIView+Constraints.swift
//  CleanCodeDemo
//
//  Created by Hervé Bérenger on 24/06/2016.
//
//

import Foundation
import UIKit

extension UIView {

    /**
     Add constraints to center self in the superview along specified axes

     - parameter axis: Axis to center the view along in its superview

     - parameter priority: The layout priority used for the constraint created (default value is Required)

     */
    @objc(ad_centerInSuperview) public func ad_centerInSuperview() {
        ad_centerInSuperview(with: .required)
    }

    @objc(ad_centerInSuperviewWithPriority:) public func ad_centerInSuperview(with priority: UILayoutPriority) {
        ad_centerInSuperview(along: .horizontal, with: priority)
        ad_centerInSuperview(along: .vertical, with: priority)
    }

    @objc(ad_centerInSuperviewAlongAxis:) public func ad_centerInSuperview(along axis: UILayoutConstraintAxis) {
        ad_centerInSuperview(along: axis, with: UILayoutPriority.required)
    }

    @objc(ad_centerInSuperviewAlongAxis:withPriority:) public func ad_centerInSuperview(along axis: UILayoutConstraintAxis, with priority: UILayoutPriority) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            ad_pinTo(view: superview, attribute: .centerX, constant: 0.0, priority: priority)
        case .vertical:
            ad_pinTo(view: superview, attribute: .centerY, constant: 0.0, priority: priority)
        }
    }

    /**
     Add constraints to pin self in superview

     - parameter edges: Edges to pin the view in its superview

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created (default value is Required)

     */
    @objc(ad_pinToSuperview) public func ad_pinToSuperview() {
        ad_pinToSuperview(edges: .all, insets: .zero)
    }

    @objc(ad_pinToSuperviewWithEdges:) public func ad_pinToSuperview(edges: UIRectEdge) {
        ad_pinToSuperview(edges: edges, insets: .zero)
    }

    @objc(ad_pinToSuperviewWithInsets:) public func ad_pinToSuperview(insets: UIEdgeInsets) {
        ad_pinToSuperview(edges: .all, insets: insets)
    }

    @objc(ad_pinToSuperviewWithEdges:insets:) public func ad_pinToSuperview(edges: UIRectEdge, insets: UIEdgeInsets) {
        ad_pinToSuperview(edges: edges, insets: insets, priority: UILayoutPriority.required)
    }

    @objc(ad_pinToSuperviewWithEdges:insets:priority:) public func ad_pinToSuperview(edges: UIRectEdge, insets: UIEdgeInsets, priority: UILayoutPriority) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            ad_pinTo(view: superview, attribute: .top, constant: insets.top, priority: priority)
        }
        if edges.contains(.left) {
            ad_pinTo(view: superview, attribute: .left, constant: insets.left, priority: priority)
        }
        if edges.contains(.bottom) {
            ad_pinTo(view: superview, attribute: .bottom, constant: -insets.bottom, priority: priority)
        }
        if edges.contains(.right) {
            ad_pinTo(view: superview, attribute: .right, constant: -insets.right, priority: priority)
        }
    }

    //MARK: - Private

    private func ad_pinTo(view: UIView, attribute: NSLayoutAttribute, constant: CGFloat, priority: UILayoutPriority = .required) {
        var constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: view,
            attribute: attribute,
            multiplier: 1.0,
            constant: constant
        )
        constraint.priority = priority
        view.addConstraint(constraint)
    }
}
