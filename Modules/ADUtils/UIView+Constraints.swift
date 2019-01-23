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
     Add max constraints to edges of superview.

     - parameter edges: Edges to pin the view in its superview

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_constrainInSuperviewWithEdges:insets:priority:)
    @discardableResult
    public func ad_constrainInSuperview(edges: UIRectEdge,
                                        insets: UIEdgeInsets,
                                        priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            edges.contains(.top) ? ad_pinMinTo(view: superview, attribute: .top, constant: insets.top, priority: priority) : nil,
            edges.contains(.left) ? ad_pinMinTo(view: superview, attribute: .left, constant: insets.left, priority: priority) : nil,
            edges.contains(.bottom) ? ad_pinMaxTo(view: superview, attribute: .bottom, constant: -insets.bottom, priority: priority) : nil,
            edges.contains(.right) ? ad_pinMaxTo(view: superview, attribute: .right, constant: -insets.right, priority: priority) : nil,
        ].compactMap { $0 }
        return constraints
    }

    /**
     Add max constraints to edges of superview with required priority

     - parameter edges: Edges to pin the view in its superview

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInSuperviewWithEdges:insets:)
    @discardableResult
    public func ad_constrainInSuperview(edges: UIRectEdge,
                                        insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrainInSuperview(edges: edges, insets: insets, priority: .required)
    }

    /**
     Add max constraints to edges of superview with no insets with required priority

     - parameter edges: Edges to pin the view in its superview

     */
    @objc(ad_constrainInSuperviewWithEdges:)
    @discardableResult
    public func ad_constrainInSuperview(edges: UIRectEdge) -> [NSLayoutConstraint] {
        return ad_constrainInSuperview(edges: edges, insets: .zero, priority: .required)
    }

    /**
     Add max constraints to all edges of superview with required priority

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInSuperviewWithInsets:)
    @discardableResult
    public func ad_constrainInSuperview(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_constrainInSuperview(edges: .all, insets: insets, priority: .required)
    }

    /**
     Add max constraints to all edges of superview with no insets with required priority

     */
    @objc(ad_constrainInSuperview)
    @discardableResult
    public func ad_constrainInSuperview() -> [NSLayoutConstraint] {
        return ad_constrainInSuperview(edges: .all, insets: .zero, priority: .required)
    }

    /**
     Add constraints to width and height anchors with size parameters as constants

     - parameter size: Size applied to the view

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_constrainToSize:priority:)
    @discardableResult
    public func ad_constrain(to size: CGSize, priority: UILayoutPriority) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            NSLayoutConstraint(
                item: self,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: size.height
            ),
            NSLayoutConstraint(
                item: self,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: size.width
            ),
        ]
        constraints.forEach { $0.priority = priority }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
     Add constraints to width and height anchors with size parameters as constants with required priority

     - parameter size: Size applied to the view

     */
    @objc(ad_constrainToSize:)
    @discardableResult
    public func ad_constrain(to size: CGSize) -> [NSLayoutConstraint] {
        return ad_constrain(to: size, priority: .required)
    }

    /**
     Add constraints to center self in the superview along specified axis

     - parameter axis: Axis to center the view along in its superview

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInSuperviewAlongAxis:priority:)
    @discardableResult
    public func ad_centerInSuperview(along axis: NSLayoutConstraint.Axis,
                                     priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let superview = self.superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint
        switch axis {
        case .horizontal:
            constraint = ad_pinTo(view: superview, attribute: .centerX, constant: 0.0, priority: priority)
        case .vertical:
            constraint = ad_pinTo(view: superview, attribute: .centerY, constant: 0.0, priority: priority)
        }
        return [constraint]
    }

    /**
     Add constraints to center self in the superview along specified axis with required priority

     - parameter axis: Axis to center the view along in its superview

     */
    @objc(ad_centerInSuperviewAlongAxis:)
    @discardableResult
    public func ad_centerInSuperview(along axis: NSLayoutConstraint.Axis) -> [NSLayoutConstraint] {
        return ad_centerInSuperview(along: axis, priority: .required)
    }

    /**
     Add constraints to center self in the superview both vertically and horizontally

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInSuperviewWithPriority:)
    @discardableResult
    public func ad_centerInSuperview(priority: UILayoutPriority) -> [NSLayoutConstraint] {
        return [
            ad_centerInSuperview(along: .horizontal, priority: priority),
            ad_centerInSuperview(along: .vertical, priority: priority),
        ].flatMap { $0 }
    }

    /**
     Add constraints to center self in the superview both vertically and horizontally with required priority

     */
    @objc(ad_centerInSuperview)
    @discardableResult
    public func ad_centerInSuperview() -> [NSLayoutConstraint] {
        return ad_centerInSuperview(priority: .required)
    }

    /**
     Add constraints to pin self in superview

     - parameter edges: Edges to pin the view in its superview

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_pinToSuperviewWithEdges:insets:priority:)
    @discardableResult
    public func ad_pinToSuperview(edges: UIRectEdge,
                                  insets: UIEdgeInsets,
                                  priority: UILayoutPriority) -> [NSLayoutConstraint] {
        guard let superview = self.superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            edges.contains(.top) ? ad_pinTo(view: superview, attribute: .top, constant: insets.top, priority: priority) : nil,
            edges.contains(.left) ? ad_pinTo(view: superview, attribute: .left, constant: insets.left, priority: priority) : nil,
            edges.contains(.bottom) ? ad_pinTo(view: superview, attribute: .bottom, constant: -insets.bottom, priority: priority) : nil,
            edges.contains(.right) ? ad_pinTo(view: superview, attribute: .right, constant: -insets.right, priority: priority) : nil,
        ].compactMap { $0 }
        return constraints
    }

    /**
     Add constraints to pin self in superview with required priority

     - parameter edges: Edges to pin the view in its superview

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToSuperviewWithEdges:insets:)
    @discardableResult
    public func ad_pinToSuperview(edges: UIRectEdge, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pinToSuperview(edges: edges, insets: insets, priority: UILayoutPriority.required)
    }

    /**
     Add constraints to pin self in superview with no insets

     - parameter edges: Edges to pin the view in its superview

     */
    @objc(ad_pinToSuperviewWithEdges:)
    @discardableResult
    public func ad_pinToSuperview(edges: UIRectEdge) -> [NSLayoutConstraint] {
        return ad_pinToSuperview(edges: edges, insets: .zero)
    }

    /**
     Add constraints to pin self in superview to all edges with required priority

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToSuperviewWithInsets:)
    @discardableResult
    public func ad_pinToSuperview(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return ad_pinToSuperview(edges: .all, insets: insets)
    }

    /**
     Add constraints to pin self in superview to all edges with no insets and required priority

     */
    @objc(ad_pinToSuperview)
    @discardableResult
    public func ad_pinToSuperview() -> [NSLayoutConstraint] {
        return ad_pinToSuperview(edges: .all, insets: .zero)
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
        )
        constraint.priority = priority
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
        )
        constraint.priority = priority
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
        )
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}
