//
//  Locale+UserPreferredTimeFormat.swift
//  ADUtils
//
//  Created by Edouard Siegel on 24/07/2020.
//

import Foundation

public extension Locale {

    /*
     courtesy of https://stackoverflow.com/a/11660380/900937

     This uses a special date template string called "j". According to the ICU Spec, "j":
     requests the preferred hour format for the locale (h, H, K, or k), as determined by whether h, H, K, or k is used
     in the standard short time format for the locale. In the implementation of such an API, 'j' must be replaced by h,
     H, K, or k before beginning a match against availableFormats data. Note that use of 'j' in a skeleton passed to an
     API is the only way to have a skeleton request a locale's preferred time cycle type (12-hour or 24-hour).

     That last sentence is important. It "is the only way to have a skeleton request a locale's preferred time cycle
     type". Since NSDateFormatter and NSCalendar are built on the ICU library, the same holds true here.
     */
    var ad_userPrefers12HoursFormat: Bool {
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: self) else {
            return false
        }
        return formatString.contains("a")
    }
}
