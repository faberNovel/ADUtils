//
//  NSLayoutConstraint+Priority.swift
//  ADUtils
//
//  Created by Denis Poifol on 05/04/2019.
//

import Foundation
import UIKit

public extension UILayoutPriority {
    static let applyIfPossible = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
}

public extension NSLayoutConstraint {
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
