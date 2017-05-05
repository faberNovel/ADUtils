//
//  OptionalUnwrapTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 31/05/2017.
//
//

import Foundation
import Quick
import ADUtils
import Nimble

private class Test {
    var testValue = 0.0

    func increaseValue(in test: Test) {
        test.testValue += 1.0
    }
}

private func delay(_ duration: TimeInterval, block: @escaping () -> ()) {
    let time = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: time, execute: block)
}

class OptionalUnwrap: QuickSpec {

    override func spec() {

        describe("unwrap") {
            it("Should unwrap properly") {
                var test: Test? = Test()
                let testResult = Test()
                test.unwrap { $0.increaseValue(in: testResult) }
                expect(testResult.testValue).to(equal(1.0))
                test = nil
                test.unwrap { $0.increaseValue(in: testResult) }
                expect(testResult.testValue).to(equal(1.0))

                // When
                waitUntil { done in
                    let test: Test? = Test()
                    let testResult = Test()
                    delay(0.1) { [weak test] in
                        test.unwrap { $0.increaseValue(in: testResult) }
                        expect(testResult.testValue).to(equal(1.0))
                        done()
                    }
                    test.unwrap { $0.increaseValue(in: testResult) }
                    expect(testResult.testValue).to(equal(1.0))
                }
            }
        }
    }
}
