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
                          size: CGSize = CGSize(width: 1, height: 1),
                          scale: CGFloat = 1.0) -> UIImage? {
        let lightModeImage = generateImage(
            withColor: color,
            size: size,
            scale: scale,
            userInterfaceStyle: .light
        )
        let darkModeImage = generateImage(
            withColor: color,
            size: size,
            scale: scale,
            userInterfaceStyle: .dark
        )
        if let darkImage = darkModeImage {
            lightModeImage?.imageAsset?.register(
                darkImage,
                with: UITraitCollection(userInterfaceStyle: .dark)
            )
        }
        return lightModeImage
    }

    // MARK: - Private

    private static func generateImage(withColor color: UIColor,
                                      size: CGSize,
                                      scale: CGFloat,
                                      userInterfaceStyle: UIUserInterfaceStyle) -> UIImage? {
        var image: UIImage?
        UITraitCollection(userInterfaceStyle: userInterfaceStyle).performAsCurrent {
            image = generateImage(withColor: color, size: size, scale: scale)
        }
        return image
    }

    private static func generateImage(withColor color: UIColor,
                                      size: CGSize,
                                      scale: CGFloat) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
