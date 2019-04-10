//
//  NSLayoutConstraint+Utils.swift
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

public extension Collection where Element == NSLayoutConstraint {
    func activate() {
        guard let array = self as? [NSLayoutConstraint] else {
            NSLayoutConstraint.activate(self.map { $0 })
            return
        }
        NSLayoutConstraint.activate(array)
    }

    func deactivate() {
        guard let array = self as? [NSLayoutConstraint] else {
            NSLayoutConstraint.deactivate(self.map { $0 })
            return
        }
        NSLayoutConstraint.deactivate(array)
    }
}
