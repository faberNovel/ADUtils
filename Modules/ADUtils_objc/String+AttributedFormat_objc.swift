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

    @objc public func adobjc_attributedString(arguments: [String],
                                        defaultAttributes: [NSAttributedString.Key: Any],
                                        formatAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString? {
        return (self as String).attributedString(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            formatAttributes: formatAttributes
        )
    }

    @objc public func adobjc_attributedString(arguments: [String],
                                        defaultAttributes: [NSAttributedString.Key: Any],
                                        differentFormatAttributes: [[NSAttributedString.Key: Any]]) -> NSAttributedString? {
        return (self as String).attributedString(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: differentFormatAttributes
        )
    }
}
