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
            let attributedString = NSMutableAttributedString(
                string: self,
                attributes: defaultAttributes
            )
            var locationOffset = 0
            try patternMatches().forEach({ (match) in
                let matchIndex = self.parameterIndex(for: match)
                let argument = arguments[matchIndex]
                let format = differentFormatAttributes[matchIndex]
                let attributedArgument = NSMutableAttributedString(
                    string: argument,
                    attributes: format
                )
                let matchRange = match.range
                attributedString.replaceCharacters(
                    in: NSMakeRange(matchRange.location + locationOffset, matchRange.length),
                    with: attributedArgument
                )
                locationOffset += attributedArgument.length - matchRange.length
            })
            return NSAttributedString(attributedString: attributedString)
        } catch {
            return nil
        }
    }

    //MARK: - Private

    private func patternRegularExpression() throws -> NSRegularExpression  {
        return try NSRegularExpression(pattern: "%(\\d\\$)?@", options: .caseInsensitive)
    }

    private func patternMatches() throws -> [NSTextCheckingResult] {
        let patternMatches = try patternRegularExpression().matches(
            in: self,
            options: [],
            range: NSMakeRange(0, self.characters.count)
        )
        return patternMatches
    }

    private func parameterIndex(for patternMatch: NSTextCheckingResult) -> Int {
        let matchRange = patternMatch.rangeAt(1)
        guard matchRange.location != NSNotFound && matchRange.length > 1 else {
            return 0
        }
        let startIndex = index(self.startIndex, offsetBy: matchRange.location)
        let endIndex = index(startIndex, offsetBy: matchRange.length-1)

        let parameterString = self[startIndex..<endIndex]
        return (Int(parameterString) ?? 0)-1
    }
}
