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
    public func ad_constrainInOwningView(edges: UIRectEdge,
                                        insets: UIEdgeInsets,
                                        priority: UILayoutPriority) {
        guard let owningView = owningView else { return }
        if edges.contains(.top) {
            ad_pinMinTo(view: owningView, attribute: .top, constant: insets.top, priority: priority)
        }
        if edges.contains(.bottom) {
            ad_pinMaxTo(view: owningView, attribute: .bottom, constant: -insets.bottom, priority: priority)
        }
        if edges.contains(.left) {
            ad_pinMinTo(view: owningView, attribute: .left, constant: insets.left, priority: priority)
        }
        if edges.contains(.right) {
            ad_pinMaxTo(view: owningView, attribute: .right, constant: -insets.right, priority: priority)
        }
    }

    /**
     Add max constraints to edges of owningView with required priority

     - parameter edges: Edges to pin the view in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInOwningViewWithEdges:insets:)
    public func ad_constrainInOwningView(edges: UIRectEdge,
                                        insets: UIEdgeInsets) {
        ad_constrainInOwningView(edges: edges, insets: insets, priority: .required)
    }

    /**
     Add max constraints to edges of owningView with no insets with required priority

     - parameter edges: Edges to pin the view in its owningView

     */
    @objc(ad_constrainInOwningViewWithEdges:)
    public func ad_constrainInOwningView(edges: UIRectEdge) {
        ad_constrainInOwningView(edges: edges, insets: .zero, priority: .required)
    }

    /**
     Add max constraints to all edges of owningView with required priority

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_constrainInOwningViewWithInsets:)
    public func ad_constrainInOwningView(insets: UIEdgeInsets) {
        ad_constrainInOwningView(edges: .all, insets: insets, priority: .required)
    }

    /**
     Add max constraints to all edges of owningView with no insets with required priority

     */
    @objc(ad_constrainInOwningView)
    public func ad_constrainInOwningView() {
        ad_constrainInOwningView(edges: .all, insets: .zero, priority: .required)
    }

    /**
     Add constraints to width and height anchors with size parameters as constants

     - parameter size: Size applied to the layoutGuide

     - parameter priority: The layout priority used for the constraints created

     */
    @objc(ad_constrainToSize:priority:) public func ad_constrain(to size: CGSize, priority: UILayoutPriority) {
        let constraints = [
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width),
        ]
        constraints.forEach { $0.priority = priority }
        constraints.forEach { $0.isActive = true }
    }

    /**
     Add constraints to width and height anchors with size parameters as constants with required priority

     - parameter size: Size applied to the layoutGuide

     */
    @objc(ad_constrainToSize:) public func ad_constrain(to size: CGSize) {
        ad_constrain(to: size, priority: .required)
    }

    /**
     Add constraints to center self in the owningView along specified axis

     - parameter axis: Axis to center the view along in its owningView

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInOwningViewAlongAxis:priority:) public func ad_centerInOwningView(along axis: NSLayoutConstraint.Axis, priority: UILayoutPriority) {
        guard let owningView = self.owningView else { return }
        switch axis {
        case .horizontal:
            ad_pinTo(view: owningView, attribute: .centerX, constant: 0.0, priority: priority)
        case .vertical:
            ad_pinTo(view: owningView, attribute: .centerY, constant: 0.0, priority: priority)
        }
    }

    /**
     Add constraints to center self in the owningView along specified axis with required priority

     - parameter axis: Axis to center the view along in its owningView

     */
    @objc(ad_centerInOwningViewAlongAxis:) public func ad_centerInOwningView(along axis: NSLayoutConstraint.Axis) {
        ad_centerInOwningView(along: axis, priority: .required)
    }

    /**
     Add constraints to center self in the owningView both vertically and horizontally

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_centerInOwningViewWithPriority:) public func ad_centerInOwningView(priority: UILayoutPriority) {
        ad_centerInOwningView(along: .horizontal, priority: priority)
        ad_centerInOwningView(along: .vertical, priority: priority)
    }

    /**
     Add constraints to center self in the owningView both vertically and horizontally with required priority

     */
    @objc(ad_centerInOwningView) public func ad_centerInOwningView() {
        ad_centerInOwningView(priority: .required)
    }

    /**
     Add constraints to pin self in owningView

     - parameter edges: Edges to pin the layoutGuide in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     - parameter priority: The layout priority used for the constraint created

     */
    @objc(ad_pinToOwningViewWithEdges:insets:priority:) public func ad_pinToOwningView(edges: UIRectEdge, insets: UIEdgeInsets, priority: UILayoutPriority) {
        guard let owningView = self.owningView else { return }
        if edges.contains(.top) {
            ad_pinTo(view: owningView, attribute: .top, constant: insets.top, priority: priority)
        }
        if edges.contains(.left) {
            ad_pinTo(view: owningView, attribute: .left, constant: insets.left, priority: priority)
        }
        if edges.contains(.bottom) {
            ad_pinTo(view: owningView, attribute: .bottom, constant: -insets.bottom, priority: priority)
        }
        if edges.contains(.right) {
            ad_pinTo(view: owningView, attribute: .right, constant: -insets.right, priority: priority)
        }
    }

    /**
     Add constraints to pin self in owningView with required priority

     - parameter edges: Edges to pin the view in its owningView

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToOwningViewWithEdges:insets:) public func ad_pinToOwningView(edges: UIRectEdge, insets: UIEdgeInsets) {
        ad_pinToOwningView(edges: edges, insets: insets, priority: UILayoutPriority.required)
    }

    /**
     Add constraints to pin self in owningView with no insets

     - parameter edges: Edges to pin the view in its owningView

     */
    @objc(ad_pinToOwningViewWithEdges:) public func ad_pinToOwningView(edges: UIRectEdge) {
        ad_pinToOwningView(edges: edges, insets: .zero)
    }

    /**
     Add constraints to pin self in owningView to all edges with required priority

     - parameter insets: UIEdgeInsets to apply for each edge

     */
    @objc(ad_pinToOwningViewWithInsets:) public func ad_pinToOwningView(insets: UIEdgeInsets) {
        ad_pinToOwningView(edges: .all, insets: insets)
    }

    /**
     Add constraints to pin self in owningView to all edges with no insets and required priority

     */
    @objc(ad_pinToOwningView) public func ad_pinToOwningView() {
        ad_pinToOwningView(edges: .all, insets: .zero)
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
