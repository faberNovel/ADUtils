//
//  NSDirectionalEdgeInsets+Utilities.swift
//  ADUtils
//
//  Created by Luc Cristol on 10/04/2020.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
@available(tvOSApplicationExtension 13.0, *)
extension NSDirectionalEdgeInsets {

    /**
     - parameter value: Used for top, leading, bottom, trailing
     */
    public init(value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }

    /**
     - parameter horizontal: Used for leading and trailing
     - parameter vertical: Used for top and bottom
     */
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /**
     Returns the total insets horizontally (leading + trailing)
     */
    public var totalHorizontal: CGFloat {
        return leading + trailing
    }

    /**
     Returns the total insets vertically (top + bottom)
     */
    public var totalVertical: CGFloat {
        return top + bottom
    }

    public init(top: CGFloat) {
        self.init(top: top, leading: 0, bottom: 0, trailing: 0)
    }

    public init(leading: CGFloat) {
        self.init(top: 0, leading: leading, bottom: 0, trailing: 0)
    }

    public init(bottom: CGFloat) {
        self.init(top: 0, leading: 0, bottom: bottom, trailing: 0)
    }

    public init(trailing: CGFloat) {
        self.init(top: 0, leading: 0, bottom: 0, trailing: trailing)
    }
}
