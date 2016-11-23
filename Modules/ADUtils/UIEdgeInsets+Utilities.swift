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
}
