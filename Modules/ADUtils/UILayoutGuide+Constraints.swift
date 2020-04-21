//
//  UILayoutGuide+Constraints.swift
//  ADUtils
//
//  Created by Denis Poifol on 12/01/2019.
//

import Foundation
import UIKit

extension UILayoutGuide {
    /**
     Add constraints to pin self in layout guide

     - parameter layoutGuide: Layout guide to pin the layout guide in

     - parameter edges: Edges to pin the layout guide in the layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_pinToLayoutGuide:edges:insets:priority:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       edges: UIRectEdge,
                       insets: UIEdgeInsets,
                       priority: UILayoutPriority) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        guard
            let owningView = owningView,
            let layoutGuideOwningView = layoutGuide.owningView,
            areInTheSameViewHierarchy(owningView, layoutGuideOwningView) else {
                return constraints
        }
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

     - parameter layoutGuide: Layout guide to pin the layout guide in

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

     - parameter layoutGuide: Layout guide to pin the layout guide in

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

     - parameter layoutGuide: Layout guide to pin the layout guide in

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

     - parameter layoutGuide: Layout guide to pin the layout guide in

     - parameter edges: Edges to pin the layout guide in the layout guide

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

     - parameter layoutGuide: Layout guide to pin the layout guide in

     - parameter edges: Edges to pin the layout guide in the layout guide

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

     - parameter layoutGuide: Layout guide to center the layout guide in

     - parameter axis: Axis to center the layout guide along in layout guide

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInLayoutGuide:alongAxis:priority:)
    @discardableResult
    public func ad_center(in layoutGuide: UILayoutGuide,
                          along axis: NSLayoutConstraint.Axis,
                          priority: UILayoutPriority) -> [NSLayoutConstraint] {
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

     - parameter layoutGuide: Layout guide to center the layout guide in

     - parameter axis: Axis to center the layout guide along in layout guide

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

     - parameter layoutGuide: Layout guide to center the layout guide in

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_centerInLayoutGuide:priority:)
    @discardableResult
    public func ad_center(in layoutGuide: UILayoutGuide,
                          priority: UILayoutPriority) -> [NSLayoutConstraint] {
        let horizontalConstraints = ad_center(
            in: layoutGuide,
            along: .horizontal,
            priority: priority
        )
        let verticalConstraints = ad_center(
            in: layoutGuide,
            along: .vertical,
            priority: priority
        )
        return horizontalConstraints + verticalConstraints
    }

    /**
     Add constraints to center self both vertically and horizontally in the layout guide with required priorities

     - parameter layoutGuide: Layout guide to center the layout guide in

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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

     - parameter edges: Edges to pin the layout guide in layout guide

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_constrainInLayoutGuide:edges:insets:priority:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             edges: UIRectEdge,
                             insets: UIEdgeInsets,
                             priority: UILayoutPriority) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.top) {
            let topConstraint = topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: insets.top)
                .priority(priority)
            constraints.append(topConstraint)
        }
        if edges.contains(.bottom) {
            let bottomConstraint = bottomAnchor
                .constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                .priority(priority)
            constraints.append(bottomConstraint)
        }
        if edges.contains(.left) {
            let leftConstraint = leftAnchor
                .constraint(greaterThanOrEqualTo: layoutGuide.leftAnchor, constant: insets.left)
                .priority(priority)
            constraints.append(leftConstraint)
        }
        if edges.contains(.right) {
            let rightConstraint = rightAnchor
                .constraint(lessThanOrEqualTo: layoutGuide.rightAnchor, constant: -insets.right)
                .priority(priority)
            constraints.append(rightConstraint)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
     Add max constraints to all edges of layout guide with no insets and required priorities

     - parameter layoutGuide: Layout guide to constrain the layout guide in

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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

     - parameter edges: Edges to pin the layout guide in layout guide

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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

     - parameter edges: Edges to pin the layout guide in layout guide

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
     Add max constraints to edges of owningView.

     - parameter edges: Edges to pin the layout guide in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_constrainInOwningViewWithEdges:insets:priority:)
    @discardableResult
    public func ad_constrainInOwningView(edges: UIRectEdge,
                                        insets: UIEdgeInsets,
                                        priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let owningView = owningView else { return [] }
        let constraints: [NSLayoutConstraint] = [
            edges.contains(.top) ? ad_pinMinTo(view: owningView, attribute: .top, constant: insets.top, priority: priority) : nil,
            edges.contains(.left) ? ad_pinMinTo(view: owningView, attribute: .left, constant: insets.left, priority: priority) : nil,
            edges.contains(.bottom) ? ad_pinMaxTo(view: owningView, attribute: .bottom, constant: -insets.bottom, priority: priority) : nil,
            edges.contains(.right) ? ad_pinMaxTo(view: owningView, attribute: .right, constant: -insets.right, priority: priority) : nil,
        ].compactMap { $0 }
        return constraints
    }

    /**
     Add max constraints to edges of owningView with required priority

     - parameter edges: Edges to pin the layout guide in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInOwningViewWithEdges:insets:)
    @discardableResult
    public func ad_constrainInOwningView(edges: UIRectEdge,
                                        insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrainInOwningView(edges: edges, insets: insets, priority: .required)
    }

    /**
     Add max constraints to edges of owningView with no insets with required priority

     - parameter edges: Edges to pin the layout guide in its owningView

     */
    @objc(ad_constrainInOwningViewWithEdges:)
    @discardableResult
    public func ad_constrainInOwningView(edges: UIRectEdge) -> [NSLayoutConstraint] {
        return ad_constrainInOwningView(edges: edges, insets: .zero, priority: .required)
    }

    /**
     Add max constraints to all edges of owningView with required priority

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInOwningViewWithInsets:)
    @discardableResult
    public func ad_constrainInOwningView(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrainInOwningView(edges: .all, insets: insets, priority: .required)
    }

    /**
     Add max constraints to all edges of owningView with no insets with required priority

     */
    @objc(ad_constrainInOwningView)
    @discardableResult
    public func ad_constrainInOwningView() -> [NSLayoutConstraint] {
        return ad_constrainInOwningView(edges: .all, insets: .zero, priority: .required)
    }

    /**
     Add constraints to width and height anchors with size parameters as constants

     - parameter size: Size applied to the layoutGuide

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_constrainToSize:priority:)
    @discardableResult
    public func ad_constrain(to size: CGSize, priority: UILayoutPriority) -> [NSLayoutConstraint] {
        let constraints = [
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width),
        ]
        constraints.forEach { $0.priority = priority }
        constraints.forEach { $0.isActive = true }
        return constraints
    }

    /**
     Add constraints to width and height anchors with size parameters as constants with required priority

     - parameter size: Size applied to the layoutGuide

     */
    @objc(ad_constrainToSize:)
    @discardableResult
    public func ad_constrain(to size: CGSize) -> [NSLayoutConstraint] {
        return ad_constrain(to: size, priority: .required)
    }

    /**
     Add constraints to center self in the owningView along specified axis

     - parameter axis: Axis to center the layout guide along in its owningView

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInOwningViewAlongAxis:priority:)
    @discardableResult
    public func ad_centerInOwningView(along axis: NSLayoutConstraint.Axis, priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let owningView = self.owningView else { return [] }
        switch axis {
        case .horizontal:
            return [ad_pinTo(view: owningView, attribute: .centerX, constant: 0.0, priority: priority)]
        case .vertical:
            return [ad_pinTo(view: owningView, attribute: .centerY, constant: 0.0, priority: priority)]
        @unknown default:
            return []
        }
    }

    /**
     Add constraints to center self in the owningView along specified axis with required priority

     - parameter axis: Axis to center the layout guide along in its owningView

     */
    @objc(ad_centerInOwningViewAlongAxis:)
    @discardableResult
    public func ad_centerInOwningView(along axis: NSLayoutConstraint.Axis) -> [NSLayoutConstraint] {
        return ad_centerInOwningView(along: axis, priority: .required)
    }

    /**
     Add constraints to center self in the owningView both vertically and horizontally

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInOwningViewWithPriority:)
    @discardableResult
    public func ad_centerInOwningView(priority: UILayoutPriority) -> [NSLayoutConstraint] {
        return [
            ad_centerInOwningView(along: .horizontal, priority: priority),
            ad_centerInOwningView(along: .vertical, priority: priority),
        ].flatMap { $0 }
    }

    /**
     Add constraints to center self in the owningView both vertically and horizontally with required priority

     */
    @objc(ad_centerInOwningView)
    @discardableResult
    public func ad_centerInOwningView() -> [NSLayoutConstraint] {
        return ad_centerInOwningView(priority: .required)
    }

    /**
     Add constraints to pin self in owningView

     - parameter edges: Edges to pin the layoutGuide in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_pinToOwningViewWithEdges:insets:priority:)
    @discardableResult
    public func ad_pinToOwningView(edges: UIRectEdge,
                                   insets: UIEdgeInsets,
                                   priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let owningView = self.owningView else { return [] }
        let constraints: [NSLayoutConstraint] = [
            edges.contains(.top) ? ad_pinTo(view: owningView, attribute: .top, constant: insets.top, priority: priority) : nil,
            edges.contains(.left) ? ad_pinTo(view: owningView, attribute: .left, constant: insets.left, priority: priority) : nil,
            edges.contains(.bottom) ? ad_pinTo(view: owningView, attribute: .bottom, constant: -insets.bottom, priority: priority) : nil,
            edges.contains(.right) ? ad_pinTo(view: owningView, attribute: .right, constant: -insets.right, priority: priority) : nil,
        ].compactMap { $0 }
        return constraints
    }

    /**
     Add constraints to pin self in owningView with required priority

     - parameter edges: Edges to pin the layout guide in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToOwningViewWithEdges:insets:)
    @discardableResult
    public func ad_pinToOwningView(edges: UIRectEdge, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pinToOwningView(edges: edges, insets: insets, priority: UILayoutPriority.required)
    }

    /**
     Add constraints to pin self in owningView with no insets

     - parameter edges: Edges to pin the layout guide in its owningView

     */
    @objc(ad_pinToOwningViewWithEdges:)
    @discardableResult
    public func ad_pinToOwningView(edges: UIRectEdge) -> [NSLayoutConstraint] {
        return ad_pinToOwningView(edges: edges, insets: .zero)
    }

    /**
     Add constraints to pin self in owningView to all edges with required priority

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToOwningViewWithInsets:)
    @discardableResult
    public func ad_pinToOwningView(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pinToOwningView(edges: .all, insets: insets)
    }

    /**
     Add constraints to pin self in owningView to all edges with no insets and required priority

     */
    @objc(ad_pinToOwningView)
    @discardableResult
    public func ad_pinToOwningView() -> [NSLayoutConstraint] {
        return ad_pinToOwningView(edges: .all, insets: .zero)
    }

    //MARK: - Private

    private func areInTheSameViewHierarchy(_ firstView: UIView, _ secondView: UIView) -> Bool {
        guard !firstView.isDescendant(of: secondView) && !secondView.isDescendant(of: firstView) else {
            return true
        }
        guard firstView.superview != nil || secondView.superview != nil else {
            return false
        }
        return areInTheSameViewHierarchy(firstView.superview ?? firstView, secondView.superview ?? secondView)
    }

    private func ad_pinTo(view: UIView,
                          attribute: NSLayoutConstraint.Attribute,
                          constant: CGFloat,
                          priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: view,
            attribute: attribute,
            multiplier: 1.0,
            constant: constant
        ).priority(priority)
        constraint.isActive = true
        return constraint
    }

    private func ad_pinMinTo(view: UIView,
                             attribute: NSLayoutConstraint.Attribute,
                             constant: CGFloat,
                             priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .greaterThanOrEqual,
            toItem: view,
            attribute: attribute,
            multiplier: 1.0,
            constant: constant
        ).priority(priority)
        constraint.isActive = true
        return constraint
    }

    private func ad_pinMaxTo(view: UIView,
                             attribute: NSLayoutConstraint.Attribute,
                             constant: CGFloat,
                             priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .lessThanOrEqual,
            toItem: view,
            attribute: attribute,
            multiplier: 1.0,
            constant: constant
        ).priority(priority)
        constraint.isActive = true
        return constraint
    }
}

@available(iOS 13.0, *)
@available(tvOSApplicationExtension 13.0, *)
extension UILayoutGuide {
    /**
     Add constraints to pin self in layout guide

     - parameter layoutGuide: Layout guide to pin the layout guide in

     - parameter directionalEdges: Edges to pin the layout guide in the layout guide

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_pinToLayoutGuide:directionalEdges:insets:priority:)
    @discardableResult
    public func ad_pin(to layoutGuide: UILayoutGuide,
                       directionalEdges: NSDirectionalRectEdge,
                       insets: NSDirectionalEdgeInsets,
                       priority: UILayoutPriority) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        guard
            let owningView = owningView,
            let layoutGuideOwningView = layoutGuide.owningView,
            areInTheSameViewHierarchy(owningView, layoutGuideOwningView) else {
                return constraints
        }
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

     - parameter layoutGuide: Layout guide to pin the layout guide in

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

     - parameter layoutGuide: Layout guide to pin the layout guide in
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

     - parameter layoutGuide: Layout guide to pin the layout guide in

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

     - parameter layoutGuide: Layout guide to pin the layout guide in

     - parameter directionalEdges: Edges to pin the layout guide in the layout guide

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

     - parameter layoutGuide: Layout guide to pin the layout guide in

     - parameter directionalEdges: Edges to pin the layout guide in the layout guide

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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

     - parameter directionalEdges: Edges to pin the layout guide in layout guide

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_constrainInLayoutGuide:directionalEdges:insets:priority:)
    @discardableResult
    public func ad_constrain(in layoutGuide: UILayoutGuide,
                             directionalEdges: NSDirectionalRectEdge,
                             insets: NSDirectionalEdgeInsets,
                             priority: UILayoutPriority) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if directionalEdges.contains(.top) {
            let topConstraint = topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: insets.top)
                .priority(priority)
            constraints.append(topConstraint)
        }
        if directionalEdges.contains(.bottom) {
            let bottomConstraint = bottomAnchor
                .constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                .priority(priority)
            constraints.append(bottomConstraint)
        }
        if directionalEdges.contains(.leading) {
            let leadingConstraint = leadingAnchor
                .constraint(greaterThanOrEqualTo: layoutGuide.leadingAnchor, constant: insets.leading)
                .priority(priority)
            constraints.append(leadingConstraint)
        }
        if directionalEdges.contains(.trailing) {
            let trailingConstraint = trailingAnchor
                .constraint(lessThanOrEqualTo: layoutGuide.trailingAnchor, constant: -insets.trailing)
                .priority(priority)
            constraints.append(trailingConstraint)
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
     Add max constraints to all edges of layout guide with no insets and required priorities

     - parameter layoutGuide: Layout guide to constrain the layout guide in
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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

     - parameter directionalEdges: Edges to pin the layout guide in layout guide

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

     - parameter layoutGuide: Layout guide to constrain the layout guide in

     - parameter directionalEdges: Edges to pin the layout guide in layout guide

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
     Add max constraints to edges of owningView.

     - parameter directionalEdges: Edges to pin the layout guide in its owningView

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_constrainInOwningViewWithDirectionalEdges:insets:priority:)
    @discardableResult
    public func ad_constrainInOwningView(directionalEdges: NSDirectionalRectEdge,
                                        insets: NSDirectionalEdgeInsets,
                                        priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let owningView = owningView else { return [] }
        let constraints: [NSLayoutConstraint] = [
            directionalEdges.contains(.top) ? ad_pinMinTo(view: owningView, attribute: .top, constant: insets.top, priority: priority) : nil,
            directionalEdges.contains(.leading) ? ad_pinMinTo(view: owningView, attribute: .leading, constant: insets.leading, priority: priority) : nil,
            directionalEdges.contains(.bottom) ? ad_pinMaxTo(view: owningView, attribute: .bottom, constant: -insets.bottom, priority: priority) : nil,
            directionalEdges.contains(.trailing) ? ad_pinMaxTo(view: owningView, attribute: .trailing, constant: -insets.trailing, priority: priority) : nil,
        ].compactMap { $0 }
        return constraints
    }

    /**
     Add max constraints to edges of owningView with required priority

     - parameter directionalEdges: Edges to pin the layout guide in its owningView

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInOwningViewWithDirectionalEdges:insets:)
    @discardableResult
    public func ad_constrainInOwningView(directionalEdges: NSDirectionalRectEdge,
                                        insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrainInOwningView(directionalEdges: directionalEdges, insets: insets, priority: .required)
    }

    /**
     Add max constraints to edges of owningView with no insets with required priority

     - parameter directionalEdges: Edges to pin the layout guide in its owningView

     */
    @objc(ad_constrainInOwningViewWithDirectionalEdges:)
    @discardableResult
    public func ad_constrainInOwningView(directionalEdges: NSDirectionalRectEdge) -> [NSLayoutConstraint] {
        return ad_constrainInOwningView(directionalEdges: directionalEdges, insets: .zero, priority: .required)
    }

    /**
     Add max constraints to all edges of owningView with required priority

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInOwningViewWithDirectionalInsets:)
    @discardableResult
    public func ad_constrainInOwningView(insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrainInOwningView(directionalEdges: .all, insets: insets, priority: .required)
    }

    /**
     Add max constraints to all edges of owningView with no insets with required priority

     - parameter usingDirectionalEdges: Boolean to determine if NSDirectionalRectEdge or UIRectEdges must be used

     */
    @objc(ad_constrainInOwningViewUsingDirectionalEdges:)
    @discardableResult
    public func ad_constrainInOwningView(usingDirectionalEdges: Bool) -> [NSLayoutConstraint] {
        return usingDirectionalEdges
        ? ad_constrainInOwningView(directionalEdges: .all, insets: .zero, priority: .required)
        : ad_constrainInOwningView(edges: .all, insets: .zero, priority: .required)
    }

    /**
     Add constraints to pin self in owningView

     - parameter directionalEdges: Edges to pin the layoutGuide in its owningView

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_pinToOwningViewWithDirectionalEdges:insets:priority:)
    @discardableResult
    public func ad_pinToOwningView(directionalEdges: NSDirectionalRectEdge,
                                   insets: NSDirectionalEdgeInsets,
                                   priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let owningView = self.owningView else { return [] }
        let constraints: [NSLayoutConstraint] = [
            directionalEdges.contains(.top) ? ad_pinTo(view: owningView, attribute: .top, constant: insets.top, priority: priority) : nil,
            directionalEdges.contains(.leading) ? ad_pinTo(view: owningView, attribute: .leading, constant: insets.leading, priority: priority) : nil,
            directionalEdges.contains(.bottom) ? ad_pinTo(view: owningView, attribute: .bottom, constant: -insets.bottom, priority: priority) : nil,
            directionalEdges.contains(.trailing) ? ad_pinTo(view: owningView, attribute: .trailing, constant: -insets.trailing, priority: priority) : nil,
        ].compactMap { $0 }
        return constraints
    }

    /**
     Add constraints to pin self in owningView with required priority

     - parameter directionalEdges: Edges to pin the layout guide in its owningView

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_pinToOwningViewWithDirectionalEdges:insets:)
    @discardableResult
    public func ad_pinToOwningView(directionalEdges: NSDirectionalRectEdge,
                                   insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pinToOwningView(directionalEdges: directionalEdges, insets: insets, priority: UILayoutPriority.required)
    }

    /**
     Add constraints to pin self in owningView with no insets

     - parameter directionalEdges: Edges to pin the layout guide in its owningView

     */
    @objc(ad_pinToOwningViewWithDirectionalEdges:)
    @discardableResult
    public func ad_pinToOwningView(directionalEdges: NSDirectionalRectEdge) -> [NSLayoutConstraint] {
        return ad_pinToOwningView(directionalEdges: directionalEdges, insets: .zero)
    }

    /**
     Add constraints to pin self in owningView to all edges with required priority

     - parameter insets: NSDirectionalEdgeInsets to apply for each edge

     */
    @objc(ad_pinToOwningViewWithDirectionalInsets:)
    @discardableResult
    public func ad_pinToOwningView(insets: NSDirectionalEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pinToOwningView(directionalEdges: .all, insets: insets)
    }

    /**
     Add constraints to pin self in owningView to all edges with no insets and required priority

     - parameter usingDirectionalEdges: Boolean to determine if NSDirectionalRectEdge or UIRectEdges must be used

     */
    @objc(ad_pinToOwningViewUsingDirectionalEdges:)
    @discardableResult
    public func ad_pinToOwningView(usingDirectionalEdges: Bool) -> [NSLayoutConstraint] {
        return usingDirectionalEdges
            ? ad_pinToOwningView(directionalEdges: .all, insets: .zero)
            : ad_pinToOwningView(edges: .all, insets: .zero)
    }
}
