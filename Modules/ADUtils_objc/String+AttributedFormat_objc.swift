//
//  String+AttributedFormat.swift
//  Pods
//
//  Created by Benjamin Lavialle on 27/12/2016.
//
//

import Foundation

//???: (Benjamin Lavialle) 12/10/16 extensions over String are not usable in objc, this is why we need an extension on NSString

extension NSString {

    public func adobjc_attributedString(arguments: [String],
                                        defaultAttributes: [String: Any],
                                        formatAttributes: [String: Any]) -> NSAttributedString? {
        return (self as String).attributedString(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            formatAttributes: formatAttributes
        )
    }

    public func adobjc_attributedString(arguments: [String],
                                        defaultAttributes: [String: Any],
                                        differentFormatAttributes: [[String: Any]]) -> NSAttributedString? {
        return (self as String).attributedString(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: differentFormatAttributes
        )
    }
}
