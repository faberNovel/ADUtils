//
//  String+Localization.swift
//  BabolatPulse
//
//  Created by Benjamin Lavialle on 06/09/16.
//
//

import Foundation

extension String {

    /**
     Provides localizedUppercaseString for iOS < 10.0
     */
    public var ad_localizedUppercaseString: String {
        guard #available(iOS 9, *) else {
            return uppercased(with: Locale.current)
        }
        return localizedUppercase
    }

    /**
     Syntaxic sugar for NSLocalizedString
     */
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
