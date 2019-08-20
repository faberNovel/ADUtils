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
                                 defaultAttributes: [NSAttributedString.Key: Any],
                                 formatAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString? {
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
                                 defaultAttributes: [NSAttributedString.Key: Any],
                                 differentFormatAttributes: [[NSAttributedString.Key: Any]]) -> NSAttributedString? {
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
                    in: NSRange(location: matchRange.location + locationOffset, length: matchRange.length),
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
        return try NSRegularExpression(pattern: "%(([1-9][0-9]*)\\$)?@", options: .caseInsensitive)
    }

    private func patternMatches() throws -> [NSTextCheckingResult] {
        let patternMatches = try patternRegularExpression().matches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: (self as NSString).length)
        )
        return patternMatches
    }

    private func parameterIndex(for patternMatch: NSTextCheckingResult) -> Int {
        let matchRange = patternMatch.range(at: 2)
        guard matchRange.location != NSNotFound && matchRange.length > 0 else {
            return 0
        }
        let parameterString = (self as NSString).substring(with: matchRange)
        guard let parameterIndex = Int(parameterString) else {
            return 0
        }
        return parameterIndex - 1
    }
}
