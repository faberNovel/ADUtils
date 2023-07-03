//
//  StringLocalizationTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 01/10/2018.
//

import Foundation
import Nimble
import Quick
import ADUtils

class StringLocalizationTests: QuickSpec {

    override class func spec() {

        it("should return the correct localized string") {
            // Given
            let key = "localized_key"

            // When
            let value = key.localized()

            // Then
            expect(value).to(equal("Localized Value"))
        }
    }
}
