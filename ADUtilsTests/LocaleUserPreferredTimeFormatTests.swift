//
//  LocaleUserPreferredTimeFormatTests.swift
//  ADUtilsTests
//
//  Created by Edouard Siegel on 24/07/2020.
//

import Foundation
import Quick
import Nimble
import ADUtils

class LocaleUserPreferredTimeFormatTests: QuickSpec {

    override class func spec() {
        describe("When using an US region locale") {
            it("should return a 12 hours format for en_US locale") {
                let locale = Locale(identifier: "en_US")
                expect(locale.ad_userPrefers12HoursFormat).to(beTrue())
            }

            it("should return a 12 hours format for fr_US locale") {
                let locale = Locale(identifier: "fr_US")
                expect(locale.ad_userPrefers12HoursFormat).to(beTrue())
            }
        }

        describe("When using an FR region locale") {
            it("should return a 24 hours format for en_FR locale") {
                let locale = Locale(identifier: "en_FR")
                expect(locale.ad_userPrefers12HoursFormat).to(beFalse())
            }

            it("should return a 24 hours format for fr_FR locale") {
                let locale = Locale(identifier: "fr_FR")
                expect(locale.ad_userPrefers12HoursFormat).to(beFalse())
            }
        }
    }

}
