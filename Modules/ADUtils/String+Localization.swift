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
     Syntaxic sugar for NSLocalizedString
     */
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
