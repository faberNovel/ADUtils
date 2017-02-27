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
            var attributedString = NSMutableAttributedString(
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
                attributedString.replaceCharactersInRange(
                    NSMakeRange(matchRange.location + locationOffset, matchRange.length),
                    withAttributedString: attributedArgument
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
        return try NSRegularExpression(pattern: "%(\\d\\$)?@", options: .CaseInsensitive)
    }

    private func patternMatches() throws -> [NSTextCheckingResult] {
        let patternMatches = try patternRegularExpression().matchesInString(
            self,
            options: [],
            range: NSMakeRange(0, self.characters.count)
        )
        return patternMatches
    }

    private func parameterIndex(for patternMatch: NSTextCheckingResult) -> Int {
        let matchRange = patternMatch.rangeAtIndex(1)
        guard matchRange.location != NSNotFound && matchRange.length > 1 else {
            return 0
        }
        let startIndex = self.startIndex.advancedBy(matchRange.location)
        let endIndex = startIndex.advancedBy(matchRange.length-1)
        let parameterString = self[startIndex..<endIndex]
        return (Int(parameterString) ?? 0)-1
    }
}
