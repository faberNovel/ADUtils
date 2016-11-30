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
     * Inset viewController as a child, inserting its view inside subview
     * subview has to be a subView of view
     * viewController's view is inserted wihtout margins
     */

    public func ad_insertChild(_ viewController: UIViewController, inSubview subview: UIView) {
        guard subview.isDescendant(of: view) else { return }
        addChildViewController(viewController)
        let viewControllerView: UIView = viewController.view
        viewControllerView.translatesAutoresizingMaskIntoConstraints = false
        subview.ad_addSubview(viewControllerView, withMargins: UIEdgeInsets.zero)
        viewController.didMove(toParentViewController: self)
    }

    /**
     * Remove viewController from parent view controller if self is its parent
     */

    public func ad_removeChild(_ viewController: UIViewController) {
        guard viewController.parent == self else { return }
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}
