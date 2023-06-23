//
//  NSLayoutConstraintPriorityTests.swift
//  ADUtilsTests
//
//  Created by Denis Poifol on 05/04/2019.
//

import Foundation
import Quick
import Nimble
import ADUtils
import UIKit

@MainActor
class NSLayoutConstraintUtilsTests: QuickSpec {

    override class func spec() {

        it("should be higher than default priorities") {
            expect(UILayoutPriority.applyIfPossible.rawValue).to(beGreaterThan(UILayoutPriority.defaultLow.rawValue))
            expect(UILayoutPriority.applyIfPossible.rawValue).to(beGreaterThan(UILayoutPriority.defaultHigh.rawValue))
            expect(UILayoutPriority.applyIfPossible.rawValue).to(beGreaterThan(UILayoutPriority.fittingSizeLevel.rawValue))
        }

        it("should be lower than required priority") {
            expect(UILayoutPriority.applyIfPossible.rawValue).to(beLessThan(UILayoutPriority.required.rawValue))
        }

        it("should set constraint priority") {
            let view = UIView()
            var constraint = view.heightAnchor.constraint(equalToConstant: 10.0)
            expect(constraint.priority).to(equal(UILayoutPriority.required))
            constraint = constraint.priority(.applyIfPossible)
            expect(constraint.priority).to(equal(UILayoutPriority.applyIfPossible))
            constraint = constraint.priority(.defaultLow)
            expect(constraint.priority).to(equal(UILayoutPriority.defaultLow))
        }

        it("should activate and deactivate constraints array") {
            let view = UIView()
            let constraints = view.ad_constrain(to: CGSize(width: 100.0, height: 100.0))
            expect(constraints.map { $0.isActive }).to(allPass(beTrue()))
            constraints.deactivate()
            expect(constraints.map { $0.isActive }).to(allPass(beFalse()))
            constraints.activate()
            expect(constraints.map { $0.isActive }).to(allPass(beTrue()))
        }

        it("should activate and deactivate constraints set") {
            let view = UIView()
            let constraints = Set(view.ad_constrain(to: CGSize(width: 100.0, height: 100.0)))
            expect(constraints.map { $0.isActive }).to(allPass(beTrue()))
            constraints.deactivate()
            expect(constraints.map { $0.isActive }).to(allPass(beFalse()))
            constraints.activate()
            expect(constraints.map { $0.isActive }).to(allPass(beTrue()))
        }
    }
}
