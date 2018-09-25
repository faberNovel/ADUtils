//
//  UIEdgeInsets+Utilities.swift
//  HSBC
//
//  Created by Pierre Felgines on 01/09/16.
//
//

import Foundation

extension UIEdgeInsets {

    public init(value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    public var horizontal: CGFloat {
        return left + right
    }

    public var vertical: CGFloat {
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
