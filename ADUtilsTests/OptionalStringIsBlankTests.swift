//
//  OptionalStringIsBlankTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 24/09/2018.
//

import Foundation
import Quick
import Nimble
import ADUtils

class OptionalStringIsBlankTests: QuickSpec {

    override class func spec() {

        it("should be blank") {
            // Given
            let emptyString: String? = ""
            let nilString: String? = nil

            // Then
            expect(emptyString.ad_isBlank).to(beTrue())
            expect(nilString.ad_isBlank).to(beTrue())
        }

        it("should not be blank") {
            // Given
            let string: String? = "abc"

            // Then
            expect(string.ad_isBlank).to(beFalse())
        }
    }
}
