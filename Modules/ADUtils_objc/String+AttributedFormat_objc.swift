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

    public func adobjc_attributedString(
        withArguments arguments: [String],
                      defaultAttributes: [String: AnyObject],
                      formatAttributes: [String: AnyObject]
        ) -> NSAttributedString? {
        return (self as String).attributedString(
            withArguments: arguments,
            defaultAttributes: defaultAttributes,
            formatAttributes: formatAttributes
        )
    }

    public func adobjc_attributedString(
        withArguments arguments: [String],
                      defaultAttributes: [String: AnyObject],
                      differentFormatAttributes: [[String: AnyObject]]
        ) -> NSAttributedString? {
        return (self as String).attributedString(
            withArguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: differentFormatAttributes
        )
    }
}
