//
//  Optional+IsBlank.swift
//  ADUtils
//
//  Created by Pierre Felgines on 24/09/2018.
//

import Foundation

public extension Optional where Wrapped == String {

    /**
     Returns true if the string is empty or nil
     */
    var ad_isBlank: Bool {
        return self?.isEmpty ?? true
    }
}
