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
            differentFormatAttributes: arguments.map { _ in return formatAttributes }
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

    // MARK: - Private

    private func patternRegularExpression() throws -> NSRegularExpression {
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

@available(iOS 15, tvOS 15.0, *)
extension String {

    /**
     Create an AttributedString using self as format, and apply same attributes for each argument

     - parameter arguments: Arguments that match format (self)

     - parameter defaultAttributes: Attributes to apply to whole string by default

     - parameter formatAttributes: Attributes to apply for each argument

     - returns: AttributedString with same attributes for each argument
     */
    public func attributedString(arguments: [String],
                                 defaultAttributes: AttributeContainer,
                                 formatAttributes: AttributeContainer) -> AttributedString {
        return attributedString(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: arguments.map { _ in return formatAttributes }
        )
    }

    /**
     Create an AttributedString using self as format, and apply different attributes for each argument

     `differentFormatAttributes[i]` is applied to `arguments[i]`

     - parameter arguments: Arguments that match format (self)

     - parameter defaultAttributes: Attributes to apply to whole string by default

     - parameter differentFormatAttributes: Attributes to apply for each argument

     - returns: AttributedString with differents attributes for each argument
     */
    public func attributedString(
        arguments: [String],
        defaultAttributes: AttributeContainer,
        differentFormatAttributes: [AttributeContainer]
    ) -> AttributedString {
        guard arguments.count == differentFormatAttributes.count else {
            assertionFailure(
                "Invalid number of format attributes given, got \(arguments.count) argument "
                + "and \(differentFormatAttributes) format arguments"
            )
            return AttributedString()
        }
        if #available(iOS 16.0, tvOS 16.0, *) {
            return attributedStringUsingRegex(
                arguments: arguments,
                defaultAttributes: defaultAttributes,
                differentFormatAttributes: differentFormatAttributes
            )
        } else {
            return attributedStringUsingNSRegularExpression(
                arguments: arguments,
                defaultAttributes: defaultAttributes,
                differentFormatAttributes: differentFormatAttributes
            )
        }
    }

}

@available(iOS 15, tvOS 15.0, *)
extension String {

    // MARK: - Internal

    internal func attributedStringUsingNSRegularExpression(
        arguments: [String],
        defaultAttributes: AttributeContainer,
        differentFormatAttributes: [AttributeContainer]
    ) -> AttributedString {
        do {
            let nsString = self as NSString
            var attributedString = AttributedString()
            var lastIndex = 0
            var previousImplicitParameterIndex: Int?
            try patternMatches().forEach { match in
                attributedString.append(
                    AttributedString(
                        nsString.substring(with: NSRange(lastIndex..<match.range.lowerBound)),
                        attributes: defaultAttributes
                    )
                )
                let matchIndex = self.parameterIndex(
                    for: match,
                    previousImplicitParameterIndex: &previousImplicitParameterIndex
                )
                let argument = arguments[matchIndex]
                let format = differentFormatAttributes[matchIndex]

                let attributedArgument = AttributedString(argument, attributes: format)
                attributedString.append(attributedArgument)
                lastIndex = match.range.upperBound
            }
            attributedString.append(
                AttributedString(
                    nsString.substring(with: NSRange(lastIndex..<nsString.length)),
                    attributes: defaultAttributes
                )
            )
            return attributedString
        } catch {
            return AttributedString()
        }
    }

    // MARK: - Private

    private func parameterIndex(for patternMatch: NSTextCheckingResult,
                                previousImplicitParameterIndex: inout Int?) -> Int {
        let matchRange = patternMatch.range(at: 2)
        guard matchRange.location != NSNotFound && matchRange.length > 0,
              let parameterString = .some((self as NSString).substring(with: matchRange)),
              let parameterIndex = Int(parameterString)
        else {
            let parameterIndex = previousImplicitParameterIndex.map { $0 + 1 } ?? 0
            previousImplicitParameterIndex = parameterIndex
            return parameterIndex
        }
        return parameterIndex - 1
    }
}

@available(iOS 16.0, tvOS 16.0, *)
extension String {
    @available(iOS 16.0, tvOS 16.0, *)
    internal func attributedStringUsingRegex(
        arguments: [String],
        defaultAttributes: AttributeContainer,
        differentFormatAttributes: [AttributeContainer]
    ) -> AttributedString {
        var attributedString = AttributedString()
        var lastIndex = self.startIndex
        var previousImplicitParameterIndex: Int?
        // swiftlint:disable:next operator_usage_whitespace
        self.matches(of: /%(?:([1-9][0-9]*)\$)?@/).forEach { (match) in
            attributedString.append(
                AttributedString(
                    self[lastIndex..<match.range.lowerBound],
                    attributes: defaultAttributes
                )
            )
            let matchIndex = self.parameterIndex(
                for: match.output,
                previousImplicitParameterIndex: &previousImplicitParameterIndex
            )
            let argument = arguments[matchIndex]
            let format = differentFormatAttributes[matchIndex]
            let attributedArgument = AttributedString(argument, attributes: format)
            attributedString.append(attributedArgument)
            lastIndex = match.range.upperBound
        }
        attributedString.append(
            AttributedString(self[lastIndex..<self.endIndex], attributes: defaultAttributes)
        )
        return attributedString
    }

    // MARK: - Private

    private func parameterIndex(
        for patternMatch: (Substring, Substring?),
        previousImplicitParameterIndex: inout Int?
    ) -> Int {
        guard
            let stringNumber = patternMatch.1,
            let explicitIndex = Int(stringNumber)
        else {
            let parameterIndex = previousImplicitParameterIndex.map { $0 + 1 } ?? 0
            previousImplicitParameterIndex = parameterIndex
            return parameterIndex
        }
        return explicitIndex - 1
    }
}
