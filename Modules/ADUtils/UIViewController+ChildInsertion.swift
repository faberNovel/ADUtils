//
//  UIViewController+ChildInsertion.swift
//  BabolatPulse
//
//  Created by Benjamin Lavialle on 06/09/16.
//
//

import Foundation
import UIKit

extension UIViewController {

    /**
     Insert a view controller as child of current view controller

     - parameter child: UIViewController to insert as child. Its view is inserted without margins

     - parameter layoutGuide: UILayoutGuide where child's view is inserted
     */
    @objc(ad_insertChild:inLayoutGuide:) public func ad_insert(child viewController: UIViewController,
                                                               in layoutGuide: UILayoutGuide) {
        guard
            let owningView = layoutGuide.owningView,
            owningView.isDescendant(of: view) else {
                return
        }
        addChild(viewController)
        let viewControllerView: UIView = viewController.view
        viewControllerView.translatesAutoresizingMaskIntoConstraints = false
        owningView.addSubview(viewControllerView)
        viewControllerView.ad_pin(to: layoutGuide)
        viewController.didMove(toParent: self)
    }

    /**
     Insert a view controller as child of current view controller

     - parameter child: UIViewController to insert as child. Its view is inserted without margins

     - parameter subview: UIView where child's view is inserted
     */
    @objc(ad_insertChild:in:) public func ad_insert(child viewController: UIViewController, in subview: UIView) {
        guard subview.isDescendant(of: view) else { return }
        addChild(viewController)
        let viewControllerView: UIView = viewController.view
        viewControllerView.translatesAutoresizingMaskIntoConstraints = false
        subview.addSubview(viewControllerView)
        viewControllerView.ad_pinToSuperview()
        viewController.didMove(toParent: self)
    }

    /**
     Remove child viewController from current view controller

     - parameter child: child UIViewController to remove. Its view is removed from its superview
     */
     @objc(ad_removeChild:) public func ad_remove(child viewController: UIViewController) {
        guard viewController.parent == self else { return }
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

@available(iOS 13.0, *)
@available(tvOSApplicationExtension 13.0, *)
extension UIViewController {

    /**
     Insert a view controller as child of current view controller

     - parameter child: UIViewController to insert as child. Its view is inserted without margins

     - parameter layoutGuide: UILayoutGuide where child's view is inserted

     - parameter usingDirectionalEdges: Boolean to determine if NSDirectionalRectEdge or UIRectEdges must be used
     */
    @objc(ad_insertChild:inLayoutGuide:usingDirectionalEdges:)
    public func ad_insert(child viewController: UIViewController,
                          in layoutGuide: UILayoutGuide,
                          usingDirectionalEdges: Bool) {
        guard
            let owningView = layoutGuide.owningView,
            owningView.isDescendant(of: view) else {
                return
        }
        addChild(viewController)
        let viewControllerView: UIView = viewController.view
        viewControllerView.translatesAutoresizingMaskIntoConstraints = false
        owningView.addSubview(viewControllerView)
        viewControllerView.ad_pin(to: layoutGuide, usingDirectionalEdges: usingDirectionalEdges)
        viewController.didMove(toParent: self)
    }

    /**
     Insert a view controller as child of current view controller

     - parameter child: UIViewController to insert as child. Its view is inserted without margins

     - parameter subview: UIView where child's view is inserted

     - parameter usingDirectionalEdges: Boolean to determine if NSDirectionalRectEdge or UIRectEdges must be used
     */
    @objc(ad_insertChild:inSubview:usingDirectionalEdges:)
    public func ad_insert(child viewController: UIViewController,
                          in subview: UIView,
                          usingDirectionalEdges: Bool) {
        guard subview.isDescendant(of: view) else { return }
        addChild(viewController)
        let viewControllerView: UIView = viewController.view
        viewControllerView.translatesAutoresizingMaskIntoConstraints = false
        subview.addSubview(viewControllerView)
        viewControllerView.ad_pinToSuperview(usingDirectionalEdges: usingDirectionalEdges)
        viewController.didMove(toParent: self)
    }
}
