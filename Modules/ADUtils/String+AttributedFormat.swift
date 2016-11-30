//
//  String+AttributedFormat.swift
//  BabolatPulse
//
//  Created by Samuel Gallet on 06/09/16.
//
//

import Foundation

extension String {

    public func attributedString(arguments: [String],
                                 defaultAttributes: [String: Any],
                                 formatAttributes: [String: Any]) -> NSAttributedString? {
        return attributedString(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: arguments.map{ _ in return formatAttributes }
        )
    }

    /**
     * create an attributed string using self as format
     * default attributes are used for self, while differentFormatAttributes are matched to arguments with the same index
     */

    public func attributedString(arguments: [String],
                                 defaultAttributes: [String: Any],
                                 differentFormatAttributes: [[String: Any]]) -> NSAttributedString? {
        guard arguments.count == differentFormatAttributes.count else { return nil }
        do {
            let regex = try NSRegularExpression(pattern: "%(\\d\\$)?@", options: .caseInsensitive)
            let result = regex.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.characters.count))
            let mutableAttributedString = NSMutableAttributedString(string: self, attributes: defaultAttributes)
            var locationOffset = 0
            for index in (0..<min(result.count, arguments.count)) {
                let attributedArgument = NSAttributedString(
                    string: arguments[index],
                    attributes: differentFormatAttributes[index]
                )
                let unmodifiedRange = result[index].range
                let range = NSMakeRange(unmodifiedRange.location + locationOffset, unmodifiedRange.length)
                mutableAttributedString.replaceCharacters(
                    in: range,
                    with: attributedArgument
                )
                locationOffset += attributedArgument.length - unmodifiedRange.length
            }
            return NSAttributedString(attributedString: mutableAttributedString)
        } catch {
            return nil
        }
    }
}
