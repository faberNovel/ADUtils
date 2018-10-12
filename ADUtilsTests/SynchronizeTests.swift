//
//  SynchronizeTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 01/10/2018.
//

import Foundation
import Nimble
import Quick
import ADUtils

class SynchronizeTests: QuickSpec {

    override func spec() {

        // TODO: (Pierre Felgines) 01/10/2018 Find more useful test
        it("should execute block") {
            // Given
            let a = 0
            var b = 0

            // When
            synchronize(a) {
                b += 1
            }

            // Then
            expect(b).to(equal(1))
        }
    }
}
