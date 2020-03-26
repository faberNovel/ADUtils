//
//  UIScreen+PixelDimension.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 26/03/2020.
//

import UIKit

public extension UIScreen {

    /**
     The dimension of a pixel in points.
     */
    var ad_pixelDimension: CGFloat {
        1 / scale
    }
}
