//
//  UIDirectionalRectEdge+Utilities.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 23/11/2021.
//

import UIKit

@available(iOS 13.0, *)
@available(tvOSApplicationExtension 13.0, *)
extension UIDirectionalRectEdge {

    public static var horizontal: UIDirectionalRectEdge {
        [.leading, .trailing]
    }

    public static var vertical: UIDirectionalRectEdge {
        [.bottom, .top]
    }
}
