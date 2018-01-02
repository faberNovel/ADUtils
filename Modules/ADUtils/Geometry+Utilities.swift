//
//  Geometry+Utilities.swift
//  ADDynamicLogLevel
//
//  Created by Gaétan Zanella on 02/01/2018.
//

import UIKit

extension CGRect {

    /// The center point of the rectangle.
    public var center: CGPoint {
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
        get {
            return CGPoint(
                x: origin.x + size.width / 2,
                y: origin.y + size.height / 2
            )
        }
    }
}
