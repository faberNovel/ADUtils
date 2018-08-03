//
//  String+Localization.swift
//  BabolatPulse
//
//  Created by Benjamin Lavialle on 06/09/16.
//
//

import Foundation

extension String {

    var localizedUppercaseString: String {
        return uppercaseStringWithLocale(NSLocale.currentLocale())
    }

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
