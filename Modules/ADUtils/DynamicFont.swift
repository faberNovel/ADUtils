//
//  DynamicFont.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 20/10/2017.
//

import Foundation
import UIKit
import SwiftUI

/**
 The DynamicFontProvider protocol provides a font depending on parameters
 */
public protocol DynamicFontProvider {

    /**
     Provides a UIKit font for the given textStyle
     - parameter textStyle: The font text style
     */
    func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont

    /**
     Provides a SwiftUI font for the given textStyle
     - parameter textStyle: The font text style
     */
    func font(forTextStyle textStyle: Font.TextStyle) -> Font
}

/**
 The DynamicFont provides an implemementation of DynamicFontProvider depending on a plist resource
 and/or a default implementation, meaning providing the system preferred font for each font
 */
public struct DynamicFont: DynamicFontProvider {

    private let provider: DynamicFontProvider

    // MARK: - DynamicFont

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

    // MARK: - DynamicFontProvider

    public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return provider.font(forTextStyle: textStyle)
    }

    public func font(forTextStyle textStyle: Font.TextStyle) -> Font {
        return provider.font(forTextStyle: textStyle)
    }
}

private struct DefaultDynamicFontProvider: DynamicFontProvider {

    // MARK: - DynamicFontProvider

    func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return UIFont.preferredFont(forTextStyle: textStyle)
    }

    func font(forTextStyle textStyle: Font.TextStyle) -> Font {
        return Font.system(textStyle)
    }
}

private struct CustomFontDynamicFontProvider: DynamicFontProvider {

    let fontDescription: FontDescription

    // MARK: - DynamicFontProvider

    func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        do {
            return try throwingFont(forTextStyle: textStyle)
        } catch {
            assertionFailure("[DynamicFont] Missing font for \(fontDescription.name) with style : \(textStyle)")
            return UIFont.preferredFont(forTextStyle: textStyle)
        }
    }

    func font(forTextStyle textStyle: Font.TextStyle) -> Font {
        do {
            return try throwingFont(forTextStyle: textStyle)
        } catch {
            assertionFailure("[DynamicFont] Missing font for \(fontDescription.name) with style : \(textStyle)")
            return Font.system(textStyle)
        }
    }

    // MARK: - Private

    private func throwingFont(forTextStyle textStyle: Font.TextStyle) throws -> Font {
        let styleDescription = try fontDescription.fontStyleDescription(for: textStyle)
        return Font.custom(styleDescription.name, size: styleDescription.size, relativeTo: textStyle)
    }

    private func throwingFont(forTextStyle textStyle: UIFont.TextStyle) throws -> UIFont {
        let styleDescription = try fontDescription.fontStyleDescription(for: textStyle)
        let customFont = UIFont(name: styleDescription.name, size: styleDescription.size)
        let font = try (customFont ?? systemFont(weightName: styleDescription.name, size: styleDescription.size))
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
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
