//
//  String+Localization_objc.swift
//  ADClusterMapView
//
//  Created by Claire Peyron on 08/03/2018.
//

import Foundation

//???: (Claire Peyron) 2018/03/08 extensions over String are not usable in objc, this is why we need an extension on NSString

extension NSString {

    @objc public func adobjc_localized() -> NSString? {
        return (self as String).localized() as NSString
    }
}
