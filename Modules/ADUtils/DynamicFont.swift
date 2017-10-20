//
//  DynamicFont.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 20/10/2017.
//

import Foundation

public protocol DynamicFontProvider {
    func font(forTextStyle textStyle: UIFontTextStyle) -> UIFont
}

public struct DynamicFont: DynamicFontProvider {

    private let provider: DynamicFontProvider

    //MARK: - DynamicFont

    public init(fontName: String? = nil) throws {
        //TODO: (Benjamin Lavialle) 2017-10-20 Improve that
        if let fontName = fontName {
            let fontDescription = try FontDescription(fontName: fontName)
            provider = CustomFontDynamicFontProvider(fontDescription: fontDescription)
        } else {
            provider = DefaultDynamicFontProvider()
        }
    }
    //MARK: - DynamicFontProvider

    public func font(forTextStyle textStyle: UIFontTextStyle) -> UIFont {
        return provider.font(forTextStyle: textStyle)
    }
}

private struct DefaultDynamicFontProvider: DynamicFontProvider {

    //MARK: - DynamicFontProvider

    func font(forTextStyle textStyle: UIFontTextStyle) -> UIFont {
        return UIFont.preferredFont(forTextStyle: textStyle)
    }
}

private struct CustomFontDynamicFontProvider: DynamicFontProvider {

    let fontDescription: FontDescription
    private let fontSizeHelper = FontSizeHelper()

    //MARK: - DynamicFontProvider

    func font(forTextStyle textStyle: UIFontTextStyle) -> UIFont {
        do {
            return try throwingFont(forTextStyle: textStyle)
        } catch {
            assertionFailure("[DynamicFont] Missing font for \(fontDescription.name) with style : \(textStyle)")
            return UIFont.preferredFont(forTextStyle: textStyle)
        }
    }

    //MARK: - Private

    private var currentSpecifiedContentSizeCategory: UIContentSizeCategory {
        var currentContentSizeCategory = UIApplication.shared.preferredContentSizeCategory
        if #available(iOS 10.0, tvOS 10.0, *) {
            if currentContentSizeCategory == .unspecified {
                //???: (Benjamin Lavialle) 2017-10-20 fallback on default category
                currentContentSizeCategory = .large
            }
        }
        return currentContentSizeCategory
    }

    private func throwingFont(forTextStyle textStyle: UIFontTextStyle) throws -> UIFont {
        let styleDescription = try fontDescription.fontStyleDescription(for: textStyle)
        if #available(iOS 11.0, tvOS 11.0, *) {
            guard let font = UIFont(name: styleDescription.name, size: styleDescription.size) else {
                throw FontDescriptionError.fontMissing
            }
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            return fontMetrics.scaledFont(for: font)
        } else {
            let currentContentSizeCategory = currentSpecifiedContentSizeCategory
            let size = fontSizeHelper.fontSize(
                matchingSize: styleDescription.size,
                withStyle: textStyle,
                contentSizeCategory: currentContentSizeCategory
            )
            let descriptor = UIFontDescriptor(name: styleDescription.name, size: size)
            return UIFont(descriptor: descriptor, size: 0.0)
        }
    }
}

private struct FontSizeHelper {

    //???: (Benjamin Lavialle) 2017-10-20 Provides a font size according to the Apple default font size for categories
    func fontSize(matchingSize size: CGFloat,
                  withStyle style: UIFontTextStyle,
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
    private let fontSizeMatrix: [UIFontTextStyle: [UIContentSizeCategory: CGFloat]] = FontSizeHelper.createFontSizeMatrix()

    private static func createFontSizeMatrix() -> [UIFontTextStyle: [UIContentSizeCategory: CGFloat]] {
        var fontSizeMatrix: [UIFontTextStyle: [UIContentSizeCategory: CGFloat]] = [
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
        if #available(iOS 9.0, tvOS 9.0, *) {
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
        }
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
