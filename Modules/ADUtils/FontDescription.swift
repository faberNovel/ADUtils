//
//  FontDescription.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 20/10/2017.
//

import Foundation

private typealias FontDescriptionDictionary = [UIFontTextStyle.RawValue: FontStyleDescription]

struct FontDescription {

    let name: String
    private let dictionary: FontDescriptionDictionary

    //MARK: - FontDescription

    init(fontName: String) throws {
        guard let url = Bundle.main.url(forResource: fontName, withExtension: "plist") else {
            throw FontDescriptionError.plistMissing
        }
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        dictionary = try decoder.decode(FontDescriptionDictionary.self, from: data)
        name = fontName
    }

    func fontStyleDescription(for fontTextStyle: UIFontTextStyle) throws -> FontStyleDescription {
        guard let fontStyleDescription = dictionary[fontTextStyle.rawValue] else {
            throw FontDescriptionError.styleForFontUnavailable
        }
        return fontStyleDescription
    }
}

struct FontStyleDescription: Decodable {
    let size: CGFloat
    let name: String
}

enum FontDescriptionError: Error {
    case styleForFontUnavailable
    case plistMissing
}
