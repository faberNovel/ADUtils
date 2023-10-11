//
//  StackViewUtilsTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 07/01/2020.
//

import Foundation
import Quick
import Nimble
import ADUtils
import UIKit

@MainActor
class StackViewUtilsTests: QuickSpec {

    override class func spec() {
        var stackView: UIStackView!

        beforeEach {
            stackView = UIStackView()
        }

        describe("Add arranged subviews") {

            it("should not add arranged subviews") {
                // When
                stackView.ad_addArrangedSubviews([])
                // Then
                expect(stackView.arrangedSubviews).to(beEmpty())
                expect(stackView.subviews).to(beEmpty())
            }

            it("should not add arranged subviews variadic") {
                // When
                stackView.ad_addArrangedSubviews()
                // Then
                expect(stackView.arrangedSubviews).to(beEmpty())
                expect(stackView.subviews).to(beEmpty())
            }

            it("should add arranged subviews") {
                // Given
                let view1 = UIView()
                let view2 = UIView()
                let views = [view1, view2]
                // When
                stackView.ad_addArrangedSubviews(views)
                // Then
                expect(stackView.arrangedSubviews).to(equal(views))
                expect(stackView.subviews).to(equal(views))
            }

            it("should add arranged subviews variadic") {
                // Given
                let view1 = UIView()
                let view2 = UIView()
                let views = [view1, view2]
                // When
                stackView.ad_addArrangedSubviews(view1, view2)
                // Then
                expect(stackView.arrangedSubviews).to(equal(views))
                expect(stackView.subviews).to(equal(views))
            }
        }

        describe("Remove arranged subviews") {

            it("should have no effect if no subviews") {
                // When
                stackView.ad_removeAllArrangedSubviews()
                // Then
                expect(stackView.arrangedSubviews).to(beEmpty())
                expect(stackView.subviews).to(beEmpty())
            }

            it("should clear the stackview") {
                // Given
                let view1 = UIView()
                let view2 = UIView()
                let views = [view1, view2]
                stackView.addArrangedSubview(view1)
                stackView.addArrangedSubview(view2)
                expect(stackView.arrangedSubviews).to(equal(views))
                expect(stackView.subviews).to(equal(views))

                // When
                stackView.ad_removeAllArrangedSubviews()

                // Then
                expect(stackView.arrangedSubviews).to(beEmpty())
                expect(stackView.subviews).to(beEmpty())
            }
        }
    }
}
