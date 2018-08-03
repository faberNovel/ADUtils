//
//  String+AttributedFormat.swift
//  BabolatPulse
//
//  Created by Samuel Gallet on 06/09/16.
//
//

import Foundation

extension String {

    /**
     Create an NSAttributedString using self as format, and apply same attributes for each argument

     - parameter arguments: Arguments that match format (self)

     - parameter defaultAttributes: Attributes to apply to whole string by default

     - parameter formatAttributes: Attributes to apply for each argument

     - returns: NSAttributedString with same attributes for each argument
     */
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
     Create an NSAttributedString using self as format, and apply different attributes for each argument

     `differentFormatAttributes[i]` is applied to `arguments[i]`

     - parameter arguments: Arguments that match format (self)

     - parameter defaultAttributes: Attributes to apply to whole string by default

     - parameter differentFormatAttributes: Attributes to apply for each argument

     - returns: NSAttributedString with differents attributes for each argument
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
