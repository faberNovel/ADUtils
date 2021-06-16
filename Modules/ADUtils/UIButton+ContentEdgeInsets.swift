//
//  UIButton+ContentEdgeInsets.swift
//  ADUtils
//
//  Created by Thomas Esterlin on 16/06/2021.
//

import Foundation
import UIKit

public extension UIButton {

    /**
     Sets the contentInsets for the button.
     - parameter top: The padding to apply above the title.
     - parameter bottom: The padding to apply under the title.
     - parameter left: The padding to apply left to the title.
     - parameter right: The padding to apply right to the title.
     */
    func ad_setInsets(top: CGFloat,
                      bottom: CGFloat,
                      left: CGFloat,
                      right: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(
            top: top,
            left: left,
            bottom: bottom,
            right: right
        )
    }

    /**
     Sets the contentInsets for the button and space the image.
     - parameter top: The padding to apply above the title.
     - parameter bottom: The padding to apply under the title.
     - parameter left: The padding to apply left to the title.
     - parameter right: The padding to apply right to the title.
     - parameter spaceBetweenImageAndTitle: The space to apply between the image and the title.
     */
    func ad_setInsets(top: CGFloat,
                      bottom: CGFloat,
                      left: CGFloat,
                      right: CGFloat,
                      spaceBetweenImageAndTitle: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(
            top: top,
            left: left,
            bottom: bottom,
            right: right + spaceBetweenImageAndTitle
        )
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: spaceBetweenImageAndTitle,
            bottom: 0,
            right: -spaceBetweenImageAndTitle
        )
    }

    /**
     Sets the contentInsets for the button.
     - parameter vertical: The padding to apply above and under the title.
     - parameter horizontal: The padding to apply left and right to the title.
     */
    func ad_setInsets(vertical: CGFloat, horizontal: CGFloat) {
        ad_setInsets(top: vertical, bottom: vertical, left: horizontal, right: horizontal)
    }

    /**
     Sets the contentInsets for the button and space the image.
     - parameter vertical: The padding to apply above and under the title.
     - parameter horizontal: The padding to apply left and right to the title.
     - parameter spaceBetweenImageAndTitle: The space to apply between the image and the title.
     */
    func ad_setInsets(vertical: CGFloat,
                      horizontal: CGFloat,
                      spaceBetweenImageAndTitle: CGFloat) {
        ad_setInsets(
            top: vertical,
            bottom: vertical,
            left: horizontal,
            right: horizontal,
            spaceBetweenImageAndTitle: spaceBetweenImageAndTitle
        )
    }

}
