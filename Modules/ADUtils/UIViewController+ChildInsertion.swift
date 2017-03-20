//
//  UIViewController+ChildInsertion.swift
//  BabolatPulse
//
//  Created by Benjamin Lavialle on 06/09/16.
//
//

import Foundation

extension UIViewController {
    /**
     Insert a view controller as child of current view controller

     - parameter child: UIViewController to insert as child. Its view is inserted without margins

     - parameter subview: UIView where child's view is inserted
     */
    @objc(ad_insertChild:in:) public func ad_insert(child viewController: UIViewController, in subview: UIView) {
        guard subview.isDescendant(of: view) else { return }
        addChildViewController(viewController)
        let viewControllerView: UIView = viewController.view
        viewControllerView.translatesAutoresizingMaskIntoConstraints = false
        subview.addSubview(viewControllerView)
        viewControllerView.ad_pinToSuperview()
        viewController.didMove(toParentViewController: self)
    }

    /**
     Remove child viewController from current view controller

     - parameter child: child UIViewController to remove. Its view is removed from its superview
     */
     @objc(ad_removeChild:) public func ad_remove(child viewController: UIViewController) {
        guard viewController.parent == self else { return }
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}
