//
//  UILayoutGuide+Constraints.swift
//  ADUtils
//
//  Created by Denis Poifol on 12/01/2019.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
extension UILayoutGuide {

    /**
     Add max constraints to edges of owningView.

     - parameter edges: Edges to pin the view in its owningView

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

     - parameter edges: Edges to pin the view in its owningView

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

     - parameter edges: Edges to pin the view in its owningView

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

     - parameter axis: Axis to center the view along in its owningView

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
        }
    }

    /**
     Add constraints to center self in the owningView along specified axis with required priority

     - parameter axis: Axis to center the view along in its owningView

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

     - parameter edges: Edges to pin the view in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToOwningViewWithEdges:insets:)
    @discardableResult
    public func ad_pinToOwningView(edges: UIRectEdge, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pinToOwningView(edges: edges, insets: insets, priority: UILayoutPriority.required)
    }

    /**
     Add constraints to pin self in owningView with no insets

     - parameter edges: Edges to pin the view in its owningView

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
