//
//  String+AttributedFormat.swift
//  BabolatPulse
//
//  Created by Samuel Gallet on 06/09/16.
//
//

import Foundation

extension String {

    public func attributedString(withArguments arguments: [String],
                                               defaultAttributes: [String: AnyObject],
                                               formatAttributes: [String: AnyObject]) -> NSAttributedString? {
        return attributedString(
            withArguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: arguments.map{ _ in return formatAttributes }
        )
    }

    /**
     * create an attributed string using self as format
     * default attributes are used for self, while differentFormatAttributes are matched to arguments with the same index
     */

    public func attributedString(withArguments arguments: [String],
                                               defaultAttributes: [String: AnyObject],
                                               differentFormatAttributes: [[String: AnyObject]]) -> NSAttributedString? {
        guard arguments.count == differentFormatAttributes.count else { return nil }
        do {
            let regex = try NSRegularExpression(pattern: "%(\\d\\$)?@", options: .CaseInsensitive)
            let result = regex.matchesInString(self, options: .ReportProgress, range: NSMakeRange(0, self.characters.count))
            let mutableAttributedString = NSMutableAttributedString(string: self, attributes: defaultAttributes)
            var locationOffset = 0
            for index in (0..<min(result.count, arguments.count)) {
                let attributedArgument = NSAttributedString(
                    string: arguments[index],
                    attributes: differentFormatAttributes[index]
                )
                let unmodifiedRange = result[index].range
                let range = NSMakeRange(unmodifiedRange.location + locationOffset, unmodifiedRange.length)
                mutableAttributedString.replaceCharactersInRange(
                    range,
                    withAttributedString: attributedArgument
                )
                locationOffset += attributedArgument.length - unmodifiedRange.length
            }
            return NSAttributedString(attributedString: mutableAttributedString)
        } catch {
            return nil
        }
    }
}
