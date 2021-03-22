//
//  UIImage+Color.swift
//  ADUtils
//
//  Created by Pierre Felgines on 15/02/2021.
//

import Foundation
import UIKit

public extension UIImage {

    /**
     Return an image from a UIColor
     - parameter color: The color to fill the image
     - parameter size: The size of the final image
     */
    static func ad_filled(with color: UIColor,
                          size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        if #available(iOS 13.0, tvOS 13.0, *) {
            let lightModeImage = generateImage(
                withColor: color,
                size: size,
                userInterfaceStyle: .light
            )
            let darkModeImage = generateImage(
                withColor: color,
                size: size,
                userInterfaceStyle: .dark
            )
            if let darkImage = darkModeImage {
                lightModeImage?.imageAsset?.register(
                    darkImage,
                    with: UITraitCollection(userInterfaceStyle: .dark)
                )
            }
            return lightModeImage
        } else {
            return generateImage(withColor: color, size: size)
        }
    }

    // MARK: - Private

    @available(iOS 13.0, tvOS 13.0, *)
    private static func generateImage(withColor color: UIColor,
                                      size: CGSize,
                                      userInterfaceStyle: UIUserInterfaceStyle) -> UIImage? {
        var image: UIImage?
            UITraitCollection(userInterfaceStyle: userInterfaceStyle).performAsCurrent {
                image = generateImage(withColor: color, size: size)
            }
        return image
    }

    private static func generateImage(withColor color: UIColor,
                                      size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
