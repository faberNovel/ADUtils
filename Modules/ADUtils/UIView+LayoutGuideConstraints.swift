//
//  UIView+LayoutGuideConstraints.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/10/2018.
//

import Foundation

extension NSLayoutConstraint {
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

@available(iOS 9.0, *)
extension UIView {

    /**
     Add constraints to pin self in layout guide

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter edges: Edges to pin the view in the layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_pinToLayoutGuide:edges:insets:priority:)
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       edges: UIRectEdge,
                       insets: UIEdgeInsets,
                       priority: UILayoutPriority) {
        guard
            let owningView = layoutGuide.owningView,
            isDescendant(of: owningView) else {
                return
        }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor
                .constraint(equalTo: layoutGuide.topAnchor, constant: insets.top)
                .priority(priority)
                .isActive = true
        }
        if edges.contains(.left) {
            leftAnchor
                .constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left)
                .priority(priority)
                .isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor
                .constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                .priority(priority)
                .isActive = true
        }
        if edges.contains(.right) {
            rightAnchor
                .constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right)
                .priority(priority)
                .isActive = true
        }
    }

    /**
     Add constraints to pin self to all edges with no insets in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     */
    @objc(ad_pinToLayoutGuide:)
    public func ad_pin(to layoutGuide: UILayoutGuide) {
        ad_pin(
            to: layoutGuide,
            edges: .all,
            insets: .zero
        )
    }

    /**
     Add constraints to pin self to all edges in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToLayoutGuide:insets:)
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       insets: UIEdgeInsets) {
        ad_pin(
            to: layoutGuide,
            edges: .all,
            insets: insets,
            priority: .required
        )
    }

    /**
     Add constraints to pin self with no insets in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter edges: Edges to pin the view in the layout guide

     */
    @objc(ad_pinToLayoutGuide:edges:)
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       edges: UIRectEdge) {
        ad_pin(
            to: layoutGuide,
            edges: edges,
            insets: .zero,
            priority: .required
        )
    }

    /**
     Add constraints to pin self in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter edges: Edges to pin the view in the layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToLayoutGuide:edges:insets:)
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       edges: UIRectEdge,
                       insets: UIEdgeInsets) {
        ad_pin(
            to: layoutGuide,
            edges: edges,
            insets: insets,
            priority: .required
        )
    }

    /**
     Add constraints to center self in the layout guide along specified axis

     - parameter layoutGuide: Layout guide to center the view in

     - parameter axis: Axis to center the view along in layout guide

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInLayoutGuide:alongAxis:priority:)
    public func ad_center(in layoutGuide: UILayoutGuide,
                          along axis: NSLayoutConstraint.Axis,
                          priority: UILayoutPriority) {
        guard
            let owningView = layoutGuide.owningView,
            isDescendant(of: owningView) else {
                return
        }
        translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)
                .priority(priority)
                .isActive = true
        case .vertical:
            centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor)
                .priority(priority)
                .isActive = true
        }
    }

    /**
     Add constraints to center self in the layout guide along specified axis with required priorities

     - parameter layoutGuide: Layout guide to center the view in

     - parameter axis: Axis to center the view along in layout guide

     */
    @objc(ad_centerInLayoutGuide:alongAxis:)
    public func ad_center(in layoutGuide: UILayoutGuide,
                          along axis: NSLayoutConstraint.Axis) {
        ad_center(
            in: layoutGuide,
            along: axis,
            priority: .required
        )
    }

    /**
     Add constraints to center self both vertically and horizontally in the layout guide

     - parameter layoutGuide: Layout guide to center the view in

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_centerInLayoutGuide:priority:)
    public func ad_center(in layoutGuide: UILayoutGuide,
                          priority: UILayoutPriority) {
        ad_center(
            in: layoutGuide,
            along: .horizontal,
            priority: priority
        )
        ad_center(
            in: layoutGuide,
            along: .vertical,
            priority: priority
        )
    }

    /**
     Add constraints to center self both vertically and horizontally in the layout guide with required priorities

     - parameter layoutGuide: Layout guide to center the view in

     */
    @objc(ad_centerInLayoutGuide:)
    public func ad_center(in layoutGuide: UILayoutGuide) {
        ad_center(
            in: layoutGuide,
            priority: .required
        )
    }
}
