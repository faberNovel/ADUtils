//
//  UIStackView+Utils.swift
//  Pods
//
//  Created by Pierre Felgines on 07/01/2020.
//

import Foundation
import UIKit

extension UIStackView {

    /**
    Removes all arranged subviews from the superview and empty the stackview.
    */
    public func ad_removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

    /**
    Add multiple arranged subviews at the same time

    - parameter subviews: The views to be added to the array of views arranged by the stack.
    */
    public func ad_addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach(addArrangedSubview(_:))
    }

    /**
    Add multiple arranged subviews at the same time

    - parameter subviews: The views to be added to the array of views arranged by the stack.
    */
    public func ad_addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview(_:))
    }
}
