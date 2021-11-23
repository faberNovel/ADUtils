//
//  NSDirectionalRectEdgeTest.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 18/11/21.
//
//

import Foundation
import Quick
import Nimble
import ADUtils

@available(iOS 13.0, *)
@available(tvOSApplicationExtension 13.0, *)
class NSDirectionalRectEdgeTest: QuickSpec {

    override func spec() {

        describe("horizontal edges") {
            let horizontalEdge: NSDirectionalRectEdge = .horizontal
            it("should contain horizontal values") {
                expect(horizontalEdge).to(contain(.trailing))
                expect(horizontalEdge).to(contain(.leading))
            }

            it("should not contain vertical values") {
                expect(horizontalEdge).toNot(contain(.bottom))
                expect(horizontalEdge).toNot(contain(.top))
            }
        }

        describe("vertical edges") {
            let verticalEdge: NSDirectionalRectEdge = .vertical
            it("should contain vertical values") {
                expect(verticalEdge).to(contain(.bottom))
                expect(verticalEdge).to(contain(.top))
            }

            it("should not contain horizontal values") {
                expect(verticalEdge).toNot(contain(.trailing))
                expect(verticalEdge).toNot(contain(.leading))
            }
        }
    }

}
