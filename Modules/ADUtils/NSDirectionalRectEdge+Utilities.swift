//
//  NSDirectionalRectEdge+Utilities.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 23/11/2021.
//

import UIKit

@available(iOS 13.0, *)
@available(tvOSApplicationExtension 13.0, *)
extension NSDirectionalRectEdge {

    public static var horizontal: NSDirectionalRectEdge {
        [.leading, .trailing]
    }

    public static var vertical: NSDirectionalRectEdge {
        [.bottom, .top]
    }
}
