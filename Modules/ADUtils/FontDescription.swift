//
//  FontDescription.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 20/10/2017.
//

import Foundation
import UIKit
import SwiftUI

private typealias FontDescriptionDictionary = [UIFont.TextStyle.RawValue: FontStyleDescription]

/**
 FontDescription fully describes a font meaning it provides a font (name and size) for each style
 */
struct FontDescription {
    /**
     The FontDescription plist resource name
     */
    let name: String
    /**
     The FontDescrption parsed plist defining a font for each style
     */
    private let dictionary: FontDescriptionDictionary

    // MARK: - FontDescription

    /**
     Create a FontDescription use the fontName plist in the given bundle
     - parameter fontName: plist name
     - parameter bundle: plist bundle
     - Note:
    The given plist should define a font for each text style with the following format :
    ```
    <dict>
        <key>UICTFontTextStyleTitle0</key>
        <dict>
            <key>name</key>
            <string>HelveticaNeue-Bold</string>
            <key>size</key>
            <integer>34</integer>
        </dict>
    </dict>
    ```
    */
    init(fontName: String, in bundle: Bundle) throws {
        guard let url = bundle.url(forResource: fontName, withExtension: "plist") else {
            throw FontDescriptionError.plistMissing
        }
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        dictionary = try decoder.decode(FontDescriptionDictionary.self, from: data)
        name = fontName
    }

    /**
     Provides the font for the given text style
     - parameter fontTextStyle: the text style
     - returns: the FontStyleDescription corresponding to the text style, as specified in the plist
     */
    func fontStyleDescription(for fontTextStyle: UIFont.TextStyle) throws -> FontStyleDescription {
        try fontStyleDescription(for: fontTextStyle.rawValue)
    }

    /**
     Provides the font for the given text style
     - parameter fontTextStyle: the text style
     - returns: the FontStyleDescription corresponding to the text style, as specified in the plist
     */
    func fontStyleDescription(for fontTextStyle: Font.TextStyle) throws -> FontStyleDescription {
        try fontStyleDescription(for: fontTextStyle.rawValue)
    }

    // MARK: - Private

    private func fontStyleDescription(for stringValue: String) throws -> FontStyleDescription {
        guard let fontStyleDescription = dictionary[stringValue] else {
            throw FontDescriptionError.styleForFontUnavailable
        }
        return fontStyleDescription
    }
}

struct FontStyleDescription: Decodable {
    /**
     The font size
     */
    let size: CGFloat
    /**
     Name describes the font, it can be:
     - the full font name, example: HelveticaNeue-Ligh
     - the system font weight, example: thin (or Thin)
     */
    let name: String
}

enum FontDescriptionError: Error {

    case styleForFontUnavailable
    case plistMissing
    case fontMissing
}

fileprivate extension Font.TextStyle {

    // MARK: - Font

    // ???: (Thomas Esterlin) 2023/03/06 I used these values to be able to keep the same plist
    // if dev want to use it for both UIKit and SwiftUI
    var rawValue: String {
        switch self {
        case .largeTitle:
#if os(tvOS)
            // ???: (Alexandre Podlewski) 03/07/2023 UIFont.TextStyle.largeTitle is not available in tvOS
            return "UICTFontTextStyleTitle0"
#else
            return UIFont.TextStyle.largeTitle.rawValue
#endif
        case .title:
            return UIFont.TextStyle.title1.rawValue
        case .title2:
            return UIFont.TextStyle.title2.rawValue
        case .title3:
            return UIFont.TextStyle.title3.rawValue
        case .headline:
            return UIFont.TextStyle.headline.rawValue
        case .subheadline:
            return UIFont.TextStyle.subheadline.rawValue
        case .body:
            return UIFont.TextStyle.body.rawValue
        case .callout:
            return UIFont.TextStyle.callout.rawValue
        case .footnote:
            return UIFont.TextStyle.footnote.rawValue
        case .caption:
            return UIFont.TextStyle.caption1.rawValue
        case .caption2:
            return UIFont.TextStyle.caption2.rawValue
        @unknown default:
            return ""
        }
    }
}
