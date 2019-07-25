//
//  DynamicFont.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 20/10/2017.
//

import Foundation
import UIKit

/**
 The DynamicFontProvider protocol provides a font depending on parameters
 */
public protocol DynamicFontProvider {

    /**
     Provides a font for the given textStyle
     - parameter textStyle: The font text style
     */
    func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont
}

/**
 The DynamicFont provides an implemementation of DynamicFontProvider depending on a plist resource
 and/or a default implementation, meaning providing the system preferred font for each font
 */
public struct DynamicFont: DynamicFontProvider {

    private let provider: DynamicFontProvider

    //MARK: - DynamicFont

    /**
     Create a DynamicFont use the fontName plist in the given bundle
     - parameter fontName: plist name
     - parameter bundle: plist bundle
     - Note:
     The plist is then used to create a FontDescription, it has to respect the FontDescription plist format
     */
    public init(fontName: String, in bundle: Bundle = Bundle.main) throws {
        let fontDescription = try FontDescription(fontName: fontName, in: bundle)
        provider = CustomFontDynamicFontProvider(fontDescription: fontDescription)
    }

    /**
     Create a DynamicFont with the system preferred font for each style
     */
    public init() {
        provider = DefaultDynamicFontProvider()
    }

    //MARK: - DynamicFontProvider

    public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return provider.font(forTextStyle: textStyle)
    }
}

private struct DefaultDynamicFontProvider: DynamicFontProvider {

    //MARK: - DynamicFontProvider

    func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return UIFont.preferredFont(forTextStyle: textStyle)
    }
}

private struct CustomFontDynamicFontProvider: DynamicFontProvider {

    let fontDescription: FontDescription
    private let fontSizeHelper = FontSizeHelper()

    //MARK: - DynamicFontProvider

    func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        do {
            return try throwingFont(forTextStyle: textStyle)
        } catch {
            assertionFailure("[DynamicFont] Missing font for \(fontDescription.name) with style : \(textStyle)")
            return UIFont.preferredFont(forTextStyle: textStyle)
        }
    }

    //MARK: - Private

    private var currentSpecifiedContentSizeCategory: UIContentSizeCategory {
        var currentContentSizeCategory = UIScreen.main.traitCollection.preferredContentSizeCategory
        if currentContentSizeCategory == .unspecified {
            //???: (Benjamin Lavialle) 2017-10-20 fallback on default category
            currentContentSizeCategory = .large
        }
        return currentContentSizeCategory
    }

    private func throwingFont(forTextStyle textStyle: UIFont.TextStyle) throws -> UIFont {
        let styleDescription = try fontDescription.fontStyleDescription(for: textStyle)
        let customFont = UIFont(name: styleDescription.name, size: styleDescription.size)
        if #available(iOS 11.0, tvOS 11.0, *) {
            let font = try (customFont ?? systemFont(weightName: styleDescription.name, size: styleDescription.size))
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            return fontMetrics.scaledFont(for: font)
        } else {
            let size = fontSizeHelper.fontSize(
                matchingSize: styleDescription.size,
                withStyle: textStyle,
                contentSizeCategory: currentSpecifiedContentSizeCategory
            )
            guard customFont != nil else {
                // TODO: (Benjamin Lavialle) 2018-03-15 Check custom font existency, otherwise fallback to system font
                return try systemFont(weightName: styleDescription.name, size: size)
            }
            let descriptor = UIFontDescriptor(name: styleDescription.name, size: size)
            return UIFont(descriptor: descriptor, size: 0.0)
        }
    }

    private func systemFont(weightName: String, size: CGFloat) throws -> UIFont {
        guard let weight = UIFont.Weight(name: weightName) else {
                throw FontDescriptionError.fontMissing
        }
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}

private extension UIFont.Weight {

    init?(name: String) {
        switch name.lowercased() {
        case "black":
            self = .black
        case "bold":
            self = .bold
        case "heavy":
            self = .heavy
        case "light":
            self = .light
        case "medium":
            self = .medium
        case "regular":
            self = .regular
        case "semibold":
            self = .semibold
        case "thin":
            self = .thin
        case "ultralight":
            self = .ultraLight
        default:
            return nil
        }
    }
}

private struct FontSizeHelper {

    //???: (Benjamin Lavialle) 2017-10-20 Provides a font size according to the Apple default font size for categories
    func fontSize(matchingSize size: CGFloat,
                  withStyle style: UIFont.TextStyle,
                  contentSizeCategory: UIContentSizeCategory) -> CGFloat {
        guard
            let contentSizeSizes = fontSizeMatrix[style] else {
                assertionFailure("[DynamicFont] Missing style \(style) inFontSizeHelper")
                return 0.0
        }
        guard
            let matchingSize = contentSizeSizes[contentSizeCategory],
            let defaultSize = contentSizeSizes[.large] else {
                assertionFailure("[DynamicFont] Missing size category \(contentSizeCategory) for style \(style)")
                return 0.0
        }
        let size = Int(size * matchingSize / defaultSize)
        return CGFloat(size)
    }

    //???: (Benjamin Lavialle) 2017-10-20 Font sizes from Apple system font
    private let fontSizeMatrix: [UIFont.TextStyle: [UIContentSizeCategory: CGFloat]] = FontSizeHelper.createFontSizeMatrix()

    private static func createFontSizeMatrix() -> [UIFont.TextStyle: [UIContentSizeCategory: CGFloat]] {
        var fontSizeMatrix: [UIFont.TextStyle: [UIContentSizeCategory: CGFloat]] = [
            .headline: [
                .accessibilityExtraExtraExtraLarge: 53.0,
                .accessibilityExtraExtraLarge: 47.0,
                .accessibilityExtraLarge: 40.0,
                .accessibilityLarge: 33.0,
                .accessibilityMedium: 28.0,
                .extraExtraExtraLarge: 23.0,
                .extraExtraLarge: 21.0,
                .extraLarge: 19.0,
                .large: 17.0,
                .medium: 16.0,
                .small: 15.0,
                .extraSmall: 14.0
            ],
            .body: [
                .accessibilityExtraExtraExtraLarge: 53.0,
                .accessibilityExtraExtraLarge: 47.0,
                .accessibilityExtraLarge: 40.0,
                .accessibilityLarge: 33.0,
                .accessibilityMedium: 28.0,
                .extraExtraExtraLarge: 23.0,
                .extraExtraLarge: 21.0,
                .extraLarge: 19.0,
                .large: 17.0,
                .medium: 16.0,
                .small: 15.0,
                .extraSmall: 14.0
            ],
            .subheadline: [
                .accessibilityExtraExtraExtraLarge: 49.0,
                .accessibilityExtraExtraLarge: 42.0,
                .accessibilityExtraLarge: 36.0,
                .accessibilityLarge: 30.0,
                .accessibilityMedium: 25.0,
                .extraExtraExtraLarge: 21.0,
                .extraExtraLarge: 19.0,
                .extraLarge: 17.0,
                .large: 15.0,
                .medium: 14.0,
                .small: 13.0,
                .extraSmall: 12.0
            ],
            .footnote: [
                .accessibilityExtraExtraExtraLarge: 44.0,
                .accessibilityExtraExtraLarge: 38.0,
                .accessibilityExtraLarge: 33.0,
                .accessibilityLarge: 27.0,
                .accessibilityMedium: 23.0,
                .extraExtraExtraLarge: 19.0,
                .extraExtraLarge: 17.0,
                .extraLarge: 15.0,
                .large: 13.0,
                .medium: 12.0,
                .small: 12.0,
                .extraSmall: 12.0
            ],
            .caption1: [
                .accessibilityExtraExtraExtraLarge: 43.0,
                .accessibilityExtraExtraLarge: 37.0,
                .accessibilityExtraLarge: 32.0,
                .accessibilityLarge: 26.0,
                .accessibilityMedium: 22.0,
                .extraExtraExtraLarge: 18.0,
                .extraExtraLarge: 16.0,
                .extraLarge: 14.0,
                .large: 12.0,
                .medium: 11.0,
                .small: 11.0,
                .extraSmall: 11.0
            ],
            .caption2: [
                .accessibilityExtraExtraExtraLarge: 40.0,
                .accessibilityExtraExtraLarge: 34.0,
                .accessibilityExtraLarge: 29.0,
                .accessibilityLarge: 24.0,
                .accessibilityMedium: 20.0,
                .extraExtraExtraLarge: 17.0,
                .extraExtraLarge: 15.0,
                .extraLarge: 13.0,
                .large: 11.0,
                .medium: 11.0,
                .small: 11.0,
                .extraSmall: 11.0
            ]
        ]
        fontSizeMatrix[.title1] = [
            .accessibilityExtraExtraExtraLarge: 58.0,
            .accessibilityExtraExtraLarge: 53.0,
            .accessibilityExtraLarge: 48.0,
            .accessibilityLarge: 43.0,
            .accessibilityMedium: 38.0,
            .extraExtraExtraLarge: 34.0,
            .extraExtraLarge: 32.0,
            .extraLarge: 30.0,
            .large: 28.0,
            .medium: 27.0,
            .small: 26.0,
            .extraSmall: 25.0
        ]
        fontSizeMatrix[.title2] = [
            .accessibilityExtraExtraExtraLarge: 56.0,
            .accessibilityExtraExtraLarge: 50.0,
            .accessibilityExtraLarge: 44.0,
            .accessibilityLarge: 39.0,
            .accessibilityMedium: 34.0,
            .extraExtraExtraLarge: 28.0,
            .extraExtraLarge: 26.0,
            .extraLarge: 24.0,
            .large: 22.0,
            .medium: 21.0,
            .small: 20.0,
            .extraSmall: 19.0
        ]
        fontSizeMatrix[.title3] = [
            .accessibilityExtraExtraExtraLarge: 55.0,
            .accessibilityExtraExtraLarge: 49.0,
            .accessibilityExtraLarge: 43.0,
            .accessibilityLarge: 37.0,
            .accessibilityMedium: 31.0,
            .extraExtraExtraLarge: 26.0,
            .extraExtraLarge: 24.0,
            .extraLarge: 22.0,
            .large: 20.0,
            .medium: 19.0,
            .small: 18.0,
            .extraSmall: 17.0
        ]
        fontSizeMatrix[.callout] = [
            .accessibilityExtraExtraExtraLarge: 51.0,
            .accessibilityExtraExtraLarge: 44.0,
            .accessibilityExtraLarge: 38.0,
            .accessibilityLarge: 32.0,
            .accessibilityMedium: 26.0,
            .extraExtraExtraLarge: 22.0,
            .extraExtraLarge: 20.0,
            .extraLarge: 18.0,
            .large: 16.0,
            .medium: 15.0,
            .small: 14.0,
            .extraSmall: 13.0
        ]
        #if os(iOS)
            if #available(iOS 11.0, *) {
                fontSizeMatrix[.largeTitle] = [
                    .accessibilityExtraExtraExtraLarge: 60.0,
                    .accessibilityExtraExtraLarge: 56.0,
                    .accessibilityExtraLarge: 52.0,
                    .accessibilityLarge: 48.0,
                    .accessibilityMedium: 44.0,
                    .extraExtraExtraLarge: 40.0,
                    .extraExtraLarge: 38.0,
                    .extraLarge: 36.0,
                    .large: 34.0,
                    .medium: 33.0,
                    .small: 32.0,
                    .extraSmall: 31.0
                ]
            }
        #endif
        return fontSizeMatrix
    }
}
