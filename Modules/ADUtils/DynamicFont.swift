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

    public init(fontName: String? = nil) {
        //TODO: (Benjamin Lavialle) 2017-10-20 Improve that
        if let fontName = fontName {
            provider = CustomFontDynamicFontProvider()
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

    //MARK: - DynamicFontProvider

    func font(forTextStyle textStyle: UIFontTextStyle) -> UIFont {
        return UIFont.preferredFont(forTextStyle: textStyle) //TODO: (Benjamin Lavialle) 2017-10-20 Implement it
    }
}
