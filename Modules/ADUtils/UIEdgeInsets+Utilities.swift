//
//  UIEdgeInsets+Utilities.swift
//  HSBC
//
//  Created by Pierre Felgines on 01/09/16.
//
//

import Foundation
import UIKit

extension UIEdgeInsets {

    /**
     - parameter value: Used for top, left, bottom, right
     */
    public init(value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    /**
     - parameter horizontal: Used for left and right
     - parameter vertical: Used for top and bottom
     */
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    /**
     Returns the total insets horizontally (left + right)
     */
    public var totalHorizontal: CGFloat {
        return left + right
    }

    /**
     Returns the total insets vertically (top + bottom)
     */
    public var totalVertical: CGFloat {
        return top + bottom
    }

    public init(top: CGFloat) {
        self.init(top: top, left: 0, bottom: 0, right: 0)
    }

    public init(left: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: 0)
    }

    public init(bottom: CGFloat) {
        self.init(top: 0, left: 0, bottom: bottom, right: 0)
    }

    public init(right: CGFloat) {
        self.init(top: 0, left: 0, bottom: 0, right: right)
    }
}
