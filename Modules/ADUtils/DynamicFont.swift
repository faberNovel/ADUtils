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

    private func throwingFont(forTextStyle textStyle: UIFontTextStyle) throws -> UIFont {
        let styleDescription = try fontDescription.fontStyleDescription(for: textStyle)
        if #available(iOS 11.0, tvOS 11.0, *) {
            guard let font = UIFont(name: styleDescription.name, size: styleDescription.size) else {
                throw FontDescriptionError.fontMissing
            }
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            return fontMetrics.scaledFont(for: font)
        } else {
            return UIFont.preferredFont(forTextStyle: textStyle) //TODO: (Benjamin Lavialle) 2017-10-20 Implement it
        }
    }
}
