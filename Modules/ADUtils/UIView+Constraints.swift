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

     - parameter priority: The layout priority used for the constraint created (default value is Required)

     */
    @objc(ad_constrainInSuperviewWithEdges:insets:priority:)
    public func ad_constrainInSuperview(edges: UIRectEdge,
                                        insets: UIEdgeInsets,
                                        priority: UILayoutPriority) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            ad_pinMinTo(view: superview, attribute: .top, constant: insets.top, priority: priority)
        }
        if edges.contains(.bottom) {
            ad_pinMaxTo(view: superview, attribute: .bottom, constant: -insets.bottom, priority: priority)
        }
        if edges.contains(.left) {
            ad_pinMinTo(view: superview, attribute: .left, constant: insets.left, priority: priority)
        }
        if edges.contains(.right) {
            ad_pinMaxTo(view: superview, attribute: .right, constant: -insets.right, priority: priority)
        }
    }

    @objc(ad_constrainInSuperviewWithEdges:insets:)
    public func ad_constrainInSuperview(edges: UIRectEdge,
                                        insets: UIEdgeInsets) {
        ad_constrainInSuperview(edges: edges, insets: insets, priority: .required)
    }

    @objc(ad_constrainInSuperviewWithEdges:)
    public func ad_constrainInSuperview(edges: UIRectEdge) {
        ad_constrainInSuperview(edges: edges, insets: .zero, priority: .required)
    }

    @objc(ad_constrainInSuperviewWithInsets:)
    public func ad_constrainInSuperview(insets: UIEdgeInsets) {
        ad_constrainInSuperview(edges: .all, insets: insets, priority: .required)
    }

    @objc(ad_constrainInSuperview)
    public func ad_constrainInSuperview() {
        ad_constrainInSuperview(edges: .all, insets: .zero, priority: .required)
    }

    /**
     Add constraints to width and height anchors with size parameters as constants

     - parameter size: Size applied to the view

     - parameter priority: The layout priority used for the constraint created (default value is Required)

     */
    @objc(ad_constrainToSize:priority:) public func ad_constrain(to size: CGSize, priority: UILayoutPriority) {
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
        addConstraints(constraints)
    }

    @objc(ad_constrainToSize:) public func ad_constrain(to size: CGSize) {
        ad_constrain(to: size, priority: .required)
    }

    /**
     Add constraints to center self in the superview along specified axes

     - parameter axis: Axis to center the view along in its superview

     - parameter priority: The layout priority used for the constraint created (default value is Required)

     */
    @objc(ad_centerInSuperview) public func ad_centerInSuperview() {
        ad_centerInSuperview(priority: .required)
    }

    @objc(ad_centerInSuperviewWithPriority:) public func ad_centerInSuperview(priority: UILayoutPriority) {
        ad_centerInSuperview(along: .horizontal, priority: priority)
        ad_centerInSuperview(along: .vertical, priority: priority)
    }

    @objc(ad_centerInSuperviewAlongAxis:) public func ad_centerInSuperview(along axis: NSLayoutConstraint.Axis) {
        ad_centerInSuperview(along: axis, priority: .required)
    }

    @objc(ad_centerInSuperviewAlongAxis:priority:) public func ad_centerInSuperview(along axis: NSLayoutConstraint.Axis, priority: UILayoutPriority) {
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

    private func ad_pinTo(view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat, priority: UILayoutPriority = .required) {
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
        view.addConstraint(constraint)
    }

    private func ad_pinMinTo(view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat, priority: UILayoutPriority = .required) {
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
        view.addConstraint(constraint)
    }

    private func ad_pinMaxTo(view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat, priority: UILayoutPriority = .required) {
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
        view.addConstraint(constraint)
    }
}
