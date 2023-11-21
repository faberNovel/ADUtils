//
//  NSDirectionalRectEdge+Utilities.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 23/11/2021.
//

import UIKit

extension NSDirectionalRectEdge {

    public static var horizontal: NSDirectionalRectEdge {
        [.leading, .trailing]
    }

    public static var vertical: NSDirectionalRectEdge {
        [.bottom, .top]
    }
}
