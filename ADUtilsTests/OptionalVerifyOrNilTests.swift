//
//  OptionalVerifyOrNilTests.swift
//  ADUtilsTests
//
//  Created by Benjamin Lavialle on 07/12/2020.
//

import Foundation
import Nimble
import Quick
import ADUtils

class OptionalVerifyOrNilTests: QuickSpec {

    override class func spec() {

        it("should return a valid object") {
            // Given
            let string = "test"
            let validString = verifyOrNil(string) { !$0.isEmpty }
            // Then
            expect(validString == string).to(beTrue())
        }

        it("should invalidate object") {
            // Given
            let string = "test"
            let invalidString = verifyOrNil(string) { $0 != string }
            // Then
            expect(invalidString).to(beNil())
        }

        it("should invalidate nil optional") {
            // Given
            let string = nil as String?
            let invalidString = verifyOrNil(string) { $0.isEmpty }
            // Then
            expect(invalidString).to(beNil())
        }

        it("should valid nil optional to execute") {
            // Given
            var executed = false
            let string = "test"
            if let _ = verifyOrNil(string, over: { !$0.isEmpty }) {
                executed = true
            }
            // Then
            expect(executed).to(beTrue())
        }

        it("should return a valid object with the optional extension") {
            // Given
            let string: String? = "test"
            let validString = string.verifying { !$0.isEmpty }
            // Then
            expect(validString == string).to(beTrue())
        }

        it("should invalidate object with the optional extension") {
            // Given
            let string: String? = "test"
            let invalidString = string.verifying { $0 != string }
            // Then
            expect(invalidString).to(beNil())
        }

        it("should invalidate nil optional with the optional extension") {
            // Given
            let string = nil as String?
            let invalidString = verifyOrNil(string) { $0.isEmpty }
            // Then
            expect(invalidString).to(beNil())
        }

        it("should valid nil optional to execute with the optional extension") {
            // Given
            var executed = false
            let string: String? = "test"
            if let _ = string.verifying({ !$0.isEmpty }) {
                executed = true
            }
            // Then
            expect(executed).to(beTrue())
        }
    }
}
