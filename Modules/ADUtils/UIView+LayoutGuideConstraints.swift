//
//  UIView+LayoutGuideConstraints.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/10/2018.
//

import Foundation
import UIKit

extension UIView {

    /**
     Add constraints to pin self in layout guide

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter edges: Edges to pin the view in the layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_pinToLayoutGuide:edges:insets:priority:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       edges: UIRectEdge,
                       insets: UIEdgeInsets,
                       priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard
            let owningView = layoutGuide.owningView,
            isDescendant(of: owningView) else {
                return []
        }
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.top) {
            let topConstraint = topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top)
                .priority(priority)
            constraints.append(topConstraint)
        }
        if edges.contains(.bottom) {
            let bottomConstraint = bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                .priority(priority)
            constraints.append(bottomConstraint)
        }
        if edges.contains(.left) {
            let leftConstraint = leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left)
                .priority(priority)
            constraints.append(leftConstraint)
        }
        if edges.contains(.right) {
            let rightConstraint = rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right)
                .priority(priority)
            constraints.append(rightConstraint)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
     Add constraints to pin self in layout guide

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_pinToLayoutGuide:insets:priority:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       insets: UIEdgeInsets,
                       priority: UILayoutPriority) -> [NSLayoutConstraint] {
        return ad_pin(to: layoutGuide, edges: .all, insets: insets, priority: priority)
    }

    /**
     Add constraints to pin self to all edges with no insets in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     */
    @objc(ad_pinToLayoutGuide:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide) -> [NSLayoutConstraint] {
        return ad_pin(
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
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pin(
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
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       edges: UIRectEdge) -> [NSLayoutConstraint] {
        return ad_pin(
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
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       edges: UIRectEdge,
                       insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pin(
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
    @discardableResult
    public func ad_center(in layoutGuide: UILayoutGuide,
                          along axis: NSLayoutConstraint.Axis,
                          priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard
            let owningView = layoutGuide.owningView,
            isDescendant(of: owningView) else {
                return []
        }
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint
        switch axis {
        case .horizontal:
            constraint = centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)
                .priority(priority)
        case .vertical:
            constraint = centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor)
                .priority(priority)
        @unknown default:
            return []
        }
        constraint.isActive = true
        return [constraint]
    }

    /**
     Add constraints to center self in the layout guide along specified axis with required priorities

     - parameter layoutGuide: Layout guide to center the view in

     - parameter axis: Axis to center the view along in layout guide

     */
    @objc(ad_centerInLayoutGuide:alongAxis:)
    @discardableResult
    public func ad_center(in layoutGuide: UILayoutGuide,
                          along axis: NSLayoutConstraint.Axis) -> [NSLayoutConstraint] {
        return ad_center(
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
    @discardableResult
    public func ad_center(in layoutGuide: UILayoutGuide,
                          priority: UILayoutPriority) -> [NSLayoutConstraint] {
        return [
            ad_center(
                in: layoutGuide,
                along: .horizontal,
                priority: priority
            ),
            ad_center(
                in: layoutGuide,
                along: .vertical,
                priority: priority
            ),
        ].flatMap { $0 }
    }

    /**
     Add constraints to center self both vertically and horizontally in the layout guide with required priorities

     - parameter layoutGuide: Layout guide to center the view in

     */
    @objc(ad_centerInLayoutGuide:)
    @discardableResult
    public func ad_center(in layoutGuide: UILayoutGuide) -> [NSLayoutConstraint] {
        return ad_center(
            in: layoutGuide,
            priority: .required
        )
    }

    /**
     Add max constraints to edges of layout guide

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter edges: Edges to pin the view in layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_constrainInLayoutGuide:edges:insets:priority:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             edges: UIRectEdge,
                             insets: UIEdgeInsets,
                             priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard
            let owningView = layoutGuide.owningView,
            isDescendant(of: owningView) else {
                return []
        }
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.top) {
            let topConstraint = topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: insets.top)
                .priority(priority)
            constraints.append(topConstraint)
        }
        if edges.contains(.bottom) {
            let bottomConstraint = bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                .priority(priority)
            constraints.append(bottomConstraint)
        }
        if edges.contains(.left) {
            let leftConstraint = leftAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leftAnchor, constant: insets.left)
                .priority(priority)
            constraints.append(leftConstraint)
        }
        if edges.contains(.right) {
            let rightConstraint = rightAnchor.constraint(lessThanOrEqualTo: layoutGuide.rightAnchor, constant: -insets.right)
                .priority(priority)
            constraints.append(rightConstraint)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
     Add max constraints to all edges of layout guide with no insets and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in

     */
    @objc(ad_constrainInLayoutGuide:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide) -> [NSLayoutConstraint] {
        return ad_constrain(
            in: layoutGuide,
            edges: .all,
            insets: .zero
        )
    }

    /**
     Add max constraints to all edges of layout guide and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInLayoutGuide:insets:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrain(
            in: layoutGuide,
            edges: .all,
            insets: insets
        )
    }

    /**
     Add max constraints to edges of layout guide with no insets and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter edges: Edges to pin the view in layout guide

     */
    @objc(ad_constrainInLayoutGuide:edges:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             edges: UIRectEdge) -> [NSLayoutConstraint] {
        return ad_constrain(
            in: layoutGuide,
            edges: edges,
            insets: .zero,
            priority: .required
        )
    }

    /**
     Add max constraints to edges of layout guide and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter edges: Edges to pin the view in layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInLayoutGuide:edges:insets:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             edges: UIRectEdge,
                             insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrain(
            in: layoutGuide,
            edges: edges,
            insets: insets,
            priority: .required
        )
    }

    /**
     Add constraints to pin self in superview's safe area layout guide

     - parameter edges: Edges to pin the view in the layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithEdges:insets:priority:)
    @discardableResult
    public func ad_pinToSuperviewSafeAreaLayoutGuide(edges: UIRectEdge,
                                                     insets: UIEdgeInsets,
                                                     priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_pin(to: layoutGuide, edges: edges, insets: insets, priority: priority)
    }

    /**
     Add constraints to pin self in superview's safe area layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithInsets:priority:)
    @discardableResult
    public func ad_pinToSuperviewSafeAreaLayoutGuide(insets: UIEdgeInsets,
                                                     priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_pin(to: layoutGuide, insets: insets, priority: priority)
    }

    /**
     Add constraints to pin self in superview's safe area layout guide

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_pinToSuperviewSafeAreaLayoutGuide)
    @discardableResult
    public func ad_pinToSuperviewSafeAreaLayoutGuide() -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_pin(to: layoutGuide)
    }

    /**
     Add constraints to pin self in superview's safe area layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithInsets:)
    @discardableResult
    public func ad_pinToSuperviewSafeAreaLayoutGuide(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_pin(to: layoutGuide, insets: insets)
    }

    /**
     Add constraints to pin self in superview's safe area layout guide

     - parameter edges: Edges to pin the view in the layout guide

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithEdges:)
    @discardableResult
    public func ad_pinToSuperviewSafeAreaLayoutGuide(edges: UIRectEdge) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_pin(to: layoutGuide, edges: edges)
    }

    /**
     Add constraints to pin self in superview's safe area layout guide

     - parameter edges: Edges to pin the view in the layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithEdges:insets:)
    @discardableResult
    public func ad_pinToSuperviewSafeAreaLayoutGuide(edges: UIRectEdge,
                                                     insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_pin(to: layoutGuide, edges: edges, insets: insets)
    }

    /**
     Add constraints to center self in superview's safe area layout guide along specified axis

     - parameter axis: Axis to center the view along in layout guide

     - parameter priority: The layout priority used for the constraint created

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_centerInSuperviewSafeAreaLayoutGuideAlongAxis:priority:)
    @discardableResult
    public func ad_centerInSuperviewSafeAreaLayoutGuide(along axis: NSLayoutConstraint.Axis,
                                                        priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_center(in: layoutGuide, along: axis, priority: priority)
    }

    /**
     Add constraints to center self in superview's safe area layout guide along specified axis

     - parameter axis: Axis to center the view along in layout guide

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_centerInSuperviewSafeAreaLayoutGuideAlongAxis:)
    @discardableResult
    public func ad_centerInSuperviewSafeAreaLayoutGuide(along axis: NSLayoutConstraint.Axis) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_center(in: layoutGuide, along: axis)
    }

    /**
     Add constraints to center self in superview's safe area layout guide along specified axis

     - parameter priority: The layout priority used for the constraint created

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_centerInSuperviewSafeAreaLayoutGuideWithPriority:)
    @discardableResult
    public func ad_centerInSuperviewSafeAreaLayoutGuide(priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_center(in: layoutGuide, priority: priority)
    }

    /**
     Add constraints to center self in superview's safe area layout guide along specified axis

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_centerInSuperviewSafeAreaLayoutGuide)
    @discardableResult
    public func ad_centerInSuperviewSafeAreaLayoutGuide() -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_center(in: layoutGuide)
    }

    /**
     Add max constraints to edges of superview's safe area layout guide

     - parameter edges: Edges to pin the view in layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithEdges:insets:priority:)
    @discardableResult
    public func ad_constrainInSuperviewSafeAreaLayoutGuide(edges: UIRectEdge,
                                                           insets: UIEdgeInsets,
                                                           priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_constrain(in: layoutGuide, edges: edges, insets: insets, priority: priority)
    }

    /**
     Add max constraints to edges of superview's safe area layout guide

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_constrainInSuperviewSafeAreaLayoutGuide)
    @discardableResult
    public func ad_constrainInSuperviewSafeAreaLayoutGuide() -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_constrain(in: layoutGuide)
    }

    /**
     Add max constraints to edges of superview's safe area layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithInsets:)
    @discardableResult
    public func ad_constrainInSuperviewSafeAreaLayoutGuide(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_constrain(in: layoutGuide, insets: insets)
    }

    /**
     Add max constraints to edges of superview's safe area layout guide

     - parameter edges: Edges to pin the view in layout guide

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithEdges:)
    @discardableResult
    public func ad_constrainInSuperviewSafeAreaLayoutGuide(edges: UIRectEdge) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_constrain(in: layoutGuide, edges: edges)
    }

    /**
     Add max constraints to edges of superview's safe area layout guide

     - parameter edges: Edges to pin the view in layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @available(iOS 11.0, tvOS 11.0, *)
    @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithEdges:insets:)
    @discardableResult
    public func ad_constrainInSuperviewSafeAreaLayoutGuide(edges: UIRectEdge,
                                                           insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
            return []
        }
        return ad_constrain(in: layoutGuide, edges: edges, insets: insets)
    }
}

@available(iOS 13.0, *)
@available(tvOSApplicationExtension 13.0, *)
extension UIView {

    /**
     Add constraints to pin self in layout guide

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter directionalEdges: NSDirectionalRectEdge to pin the view in the layout guide

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_pinToLayoutGuide:directionalEdges:insets:priority:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       directionalEdges: NSDirectionalRectEdge,
                       insets: NSDirectionalEdgeInsets,
                       priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard
            let owningView = layoutGuide.owningView,
            isDescendant(of: owningView) else {
                return []
        }
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if directionalEdges.contains(.top) {
            let topConstraint = topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top)
                .priority(priority)
            constraints.append(topConstraint)
        }
        if directionalEdges.contains(.bottom) {
            let bottomConstraint = bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                .priority(priority)
            constraints.append(bottomConstraint)
        }
        if directionalEdges.contains(.leading) {
            let leadingConstraint = leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.leading)
                .priority(priority)
            constraints.append(leadingConstraint)
        }
        if directionalEdges.contains(.trailing) {
            let trailingConstraint = trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.trailing)
                .priority(priority)
            constraints.append(trailingConstraint)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
     Add constraints to pin self in layout guide

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_pinToLayoutGuide:directionalInsets:priority:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       insets: NSDirectionalEdgeInsets,
                       priority: UILayoutPriority) -> [NSLayoutConstraint] {
        return ad_pin(to: layoutGuide, directionalEdges: .all, insets: insets, priority: priority)
    }

    /**
     Add constraints to pin self to all edges with no insets in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in
     - parameter usingDirectionalEdges: Boolean to determine if NSDirectionalRectEdge or UIRectEdges must be used

     */
    @objc(ad_pinToLayoutGuide:usingDirectionalEdges:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide, usingDirectionalEdges: Bool) -> [NSLayoutConstraint] {
        return usingDirectionalEdges
            ? ad_pin(to: layoutGuide, directionalEdges: .all, insets: .zero)
            : ad_pin(to: layoutGuide, edges: .all, insets: .zero)
    }

    /**
     Add constraints to pin self to all edges in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_pinToLayoutGuide:directionalInsets:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pin(
            to: layoutGuide,
            directionalEdges: .all,
            insets: insets,
            priority: .required
        )
    }

    /**
     Add constraints to pin self with no insets in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter directionalEdges: NSDirectionalRectEdge to pin the view in the layout guide

     */
    @objc(ad_pinToLayoutGuide:directionalEdges:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       directionalEdges: NSDirectionalRectEdge) -> [NSLayoutConstraint] {
        return ad_pin(
            to: layoutGuide,
            directionalEdges: directionalEdges,
            insets: .zero,
            priority: .required
        )
    }

    /**
     Add constraints to pin self in layout guide with required priorities

     - parameter layoutGuide: Layout guide to pin the view in

     - parameter directionalEdges: NSDirectionalRectEdge to pin the view in the layout guide

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_pinToLayoutGuide:directionalEdges:insets:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       directionalEdges: NSDirectionalRectEdge,
                       insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pin(
            to: layoutGuide,
            directionalEdges: directionalEdges,
            insets: insets,
            priority: .required
        )
    }

    /**
     Add max constraints to edges of layout guide

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_constrainInLayoutGuide:directionalEdges:insets:priority:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             directionalEdges: NSDirectionalRectEdge,
                             insets: NSDirectionalEdgeInsets,
                             priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard
            let owningView = layoutGuide.owningView,
            isDescendant(of: owningView) else {
                return []
        }
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if directionalEdges.contains(.top) {
            let topConstraint = topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: insets.top)
                .priority(priority)
            constraints.append(topConstraint)
        }
        if directionalEdges.contains(.bottom) {
            let bottomConstraint = bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                .priority(priority)
            constraints.append(bottomConstraint)
        }
        if directionalEdges.contains(.leading) {
            let leadingConstraint = leadingAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leadingAnchor, constant: insets.leading)
                .priority(priority)
            constraints.append(leadingConstraint)
        }
        if directionalEdges.contains(.trailing) {
            let trailingConstraint = trailingAnchor.constraint(lessThanOrEqualTo: layoutGuide.trailingAnchor, constant: -insets.trailing)
                .priority(priority)
            constraints.append(trailingConstraint)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
     Add max constraints to all edges of layout guide with no insets and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in
     - parameter usingDirectionalEdges: Boolean to determine if NSDirectionalRectEdge or UIRectEdges must be used

     */
    @objc(ad_constrainInLayoutGuide:usingDirectionalEdges:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide, usingDirectionalEdges: Bool) -> [NSLayoutConstraint] {
        return usingDirectionalEdges
            ? ad_constrain(in: layoutGuide, directionalEdges: .all, insets: .zero)
            : ad_constrain(in: layoutGuide, edges: .all, insets: .zero)
    }

    /**
     Add max constraints to all edges of layout guide and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInLayoutGuide:directionalInsets:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrain(
            in: layoutGuide,
            directionalEdges: .all,
            insets: insets
        )
    }

    /**
     Add max constraints to edges of layout guide with no insets and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

     */
    @objc(ad_constrainInLayoutGuide:directionalEdges:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             directionalEdges: NSDirectionalRectEdge) -> [NSLayoutConstraint] {
        return ad_constrain(
            in: layoutGuide,
            directionalEdges: directionalEdges,
            insets: .zero,
            priority: .required
        )
    }

    /**
     Add max constraints to edges of layout guide and required priorities

     - parameter layoutGuide: Layout guide to constrain the view in

     - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInLayoutGuide:directionalEdges:insets:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             directionalEdges: NSDirectionalRectEdge,
                             insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrain(
            in: layoutGuide,
            directionalEdges: directionalEdges,
            insets: insets,
            priority: .required
        )
    }

    /**
        Add constraints to pin self in superview's safe area layout guide

        - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

        - parameter insets: NSDirectionalEdgeInsets to apply for each edge

        - parameter priority: The layout priority used for the constraints created

        */
       @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithDirectionalEdges:insets:priority:)
       @discardableResult
       public func ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: NSDirectionalRectEdge,
                                                        insets: NSDirectionalEdgeInsets,
                                                        priority: UILayoutPriority) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_pin(to: layoutGuide, directionalEdges: directionalEdges, insets: insets, priority: priority)
       }

       /**
        Add constraints to pin self in superview's safe area layout guide

        - parameter insets: NSDirectionalEdgeInsets to apply for each edge

        - parameter priority: The layout priority used for the constraints created

        */
       @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithDirectionalInsets:priority:)
       @discardableResult
       public func ad_pinToSuperviewSafeAreaLayoutGuide(insets: NSDirectionalEdgeInsets,
                                                        priority: UILayoutPriority) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_pin(to: layoutGuide, insets: insets, priority: priority)
       }

       /**
        Add constraints to pin self in superview's safe area layout guide

        - parameter insets: UIEdgeInsets to apply for each edge

        */
       @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithDirectionalInsets:)
       @discardableResult
       public func ad_pinToSuperviewSafeAreaLayoutGuide(
        insets: NSDirectionalEdgeInsets
       ) -> [NSLayoutConstraint] {
        guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_pin(to: layoutGuide, insets: insets)
       }

       /**
        Add constraints to pin self in superview's safe area layout guide

        - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

        */
       @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithDirectionalEdges:)
       @discardableResult
       public func ad_pinToSuperviewSafeAreaLayoutGuide(
        directionalEdges: NSDirectionalRectEdge
       ) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_pin(to: layoutGuide, directionalEdges: directionalEdges)
       }

       /**
        Add constraints to pin self in superview's safe area layout guide

        - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

        - parameter insets: NSDirectionalEdgeInsets to apply for each edge

        */
       @objc(ad_pinToSuperviewSafeAreaLayoutGuideWithDirectionalEdges:insets:)
       @discardableResult
       public func ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: NSDirectionalRectEdge,
                                                        insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_pin(to: layoutGuide, directionalEdges: directionalEdges, insets: insets)
       }

       /**
        Add max constraints to edges of superview's safe area layout guide

        - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

        - parameter insets: NSDirectionalEdgeInsets to apply for each edge

        - parameter priority: The layout priority used for the constraint created

        */
       @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithDirectionalEdges:insets:priority:)
       @discardableResult
       public func ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: NSDirectionalRectEdge,
                                                              insets: NSDirectionalEdgeInsets,
                                                              priority: UILayoutPriority) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_constrain(in: layoutGuide, directionalEdges: directionalEdges, insets: insets, priority: priority)
       }

       /**
        Add max constraints to edges of superview's safe area layout guide

        - parameter insets: NSDirectionalEdgeInsets to apply for each edge

        */
       @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithDirectionalInsets:)
       @discardableResult
       public func ad_constrainInSuperviewSafeAreaLayoutGuide(insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_constrain(in: layoutGuide, insets: insets)
       }

       /**
        Add max constraints to edges of superview's safe area layout guide

        - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

        */
       @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithDirectionalEdges:)
       @discardableResult
       public func ad_constrainInSuperviewSafeAreaLayoutGuide(
        directionalEdges: NSDirectionalRectEdge
       ) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_constrain(in: layoutGuide, directionalEdges: directionalEdges)
       }

       /**
        Add max constraints to edges of superview's safe area layout guide

        - parameter directionalEdges: NSDirectionalRectEdge to pin the view in layout guide

        - parameter insets: NSDirectionalEdgeInsets to apply for each edge

        */
       @objc(ad_constrainInSuperviewSafeAreaLayoutGuideWithDirectionalEdges:insets:)
       @discardableResult
       public func ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: NSDirectionalRectEdge,
                                                              insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
           guard let layoutGuide = superview?.safeAreaLayoutGuide else {
               return []
           }
           return ad_constrain(in: layoutGuide, directionalEdges: directionalEdges, insets: insets)
       }
}
