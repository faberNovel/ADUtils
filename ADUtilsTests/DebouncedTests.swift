//
//  DebouncedTests.swift
//  ADUtilsTests
//
//  Created by Jonathan Seguin on 13/02/2020.
//

import Foundation
import Nimble
import Quick
import ADUtils
@testable import ADUtilsApp

private enum Constants {
    static let delay: TimeInterval = 1.0
}

/// Test for regular Debouncer class
class DebouncerTests: QuickSpec {

    override func spec() {

        var debouncer: Debouncer?
        var counter: Int = 0

        beforeEach {
            debouncer?.debounce {} // reset action
            debouncer = Debouncer(delay: Constants.delay, queue: .main)
            counter = 0
        }

        it("should not execute before delay") {
            expect(counter).to(equal(0))
            debouncer?.debounce {
                counter += 1
            }
            expect(counter).to(equal(0))
        }

        it("should wait end of delay before execution") {
            expect(counter).to(equal(0))
            debouncer?.debounce {
                counter += 1
            }
            expect(counter).to(equal(0))
            waitUntil(timeout: .seconds(2 * Int(Constants.delay))) { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(Constants.delay))) {
                    expect(counter).to(equal(1))
                    done()
                }
            }
        }

        it("should reset delay if action is called again being executed the first time") {
            expect(counter).to(equal(0))
            debouncer?.debounce {
                counter += 1
            }

            let reducedDelay = Int(Constants.delay) / 2
            waitUntil(timeout: .seconds(2 * Int(Constants.delay))) { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(reducedDelay)) {
                    expect(counter).to(equal(0))
                    debouncer?.debounce {
                        counter += 1
                    }
                    done()
                }
            }

            waitUntil(timeout: .seconds(2 * Int(Constants.delay))) { done in
                let deadline: DispatchTime = .now()
                    + .seconds(Int(Constants.delay))
                    + .seconds(reducedDelay)
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    expect(counter).to(equal(1))
                    done()
                }
            }
        }
    }
}

/// Test for property wrapper
class DebouncedTests: QuickSpec {

    @Debounced(delay: Constants.delay, queue: .main)
    private var toggleAction: () -> Void
    private var actionExecuted: Bool = false

    override func spec() {

        beforeEach {
            self.actionExecuted = false
            self.toggleAction = {
                self.actionExecuted = true
            }
        }

        it("should not execute before delay") {
            expect(self.actionExecuted).to(beFalse())
            self.toggleAction()
            expect(self.actionExecuted).to(beFalse())
        }

        it("should wait end of delay before execution") {
            expect(self.actionExecuted).to(beFalse())
            self.toggleAction()
            waitUntil(timeout: .seconds(2 * Int(Constants.delay))) { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(Constants.delay))) {
                    expect(self.actionExecuted).to(beTrue())
                    done()
                }
            }
        }

        it("should reset delay if action is called again being executed the first time") {
            expect(self.actionExecuted).to(beFalse())
            self.toggleAction()

            let reducedDelay = Int(Constants.delay) / 2
            waitUntil(timeout: .seconds(2 * Int(Constants.delay))) { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(reducedDelay)) {
                    expect(self.actionExecuted).to(beFalse())
                    self.toggleAction()
                    expect(self.actionExecuted).to(beFalse())
                    done()
                }
            }

            waitUntil(timeout: .seconds(2 * Int(Constants.delay))) { done in
                let deadline: DispatchTime = .now()
                    + .seconds(Int(Constants.delay))
                    + .seconds(reducedDelay)
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    expect(self.actionExecuted).to(beTrue())
                    done()
                }
            }
        }

        it("should not have retain cycle") {
            class ObjectWithDebouncedWrapper {
                @Debounced(delay: Constants.delay, queue: .main)
                var debounced: () -> Void
                var debouncedWrapper: Debounced { _debounced }
            }
            var object: ObjectWithDebouncedWrapper? = ObjectWithDebouncedWrapper()
            object?.debounced = {}
            weak var weakReference: Debouncer? = object?.debouncedWrapper

            expect(weakReference).notTo(beNil())
            object = nil
            expect(weakReference).to(beNil())
        }
    }
}
