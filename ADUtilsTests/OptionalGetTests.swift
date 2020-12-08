//
//  OptionalGetTests.swift
//  ADUtilsTests
//
//  Created by Gaétan Zanella on 27/03/2020.
//

import Foundation
import Nimble
import Quick
import ADUtils

class OptionalGetTests: QuickSpec {

    override func spec() {

        it("should throw an error") {
            // Given
            let optional = nil as String?

            // Then
            expect {
                let toto = try optional.get()
                return expect(toto).to(beNil())
            }
            .to(throwError(Optional<String>.Error.isNil))
        }

        it("should return the wrapped value") {
            // Given
            let optional = "toto" as String?

            // Then
            expect {
                let toto = try optional.get()
                return expect(toto).to(equal("toto"))
            }
            .toNot(throwError())
        }
    }
}
