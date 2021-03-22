//
//  UIButton+BackgroundColor.swift
//  ADUtils
//
//  Created by Pierre Felgines on 15/02/2021.
//

import Foundation

public extension UIButton {

    /**
     Sets the background image to use for the specified button state.
     - parameter backgroundColor: The background color to use for the specified state.
     - parameter state: The state that uses the specified color.
     */
    func ad_setBackgroundColor(_ backgroundColor: UIColor?,
                               for state: UIControl.State) {
        let image = backgroundColor.flatMap { UIImage.ad_filled(with: $0) }
        setBackgroundImage(image, for: state)
    }
}
