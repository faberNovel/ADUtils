//
//  UINavigationController+PopCompletion.swift
//  ADUtils
//
//  Created by Pierre Felgines on 04/05/2020.
//

import Foundation
import UIKit

public extension UINavigationController {

    /**
     Pops the top view controller from the navigation stack and updates the display.
     - parameter animated: Set this value to animate or not the transition
     - parameter completion: A closure called when the animation is finished
     */
    func ad_popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
