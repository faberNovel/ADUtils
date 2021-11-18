//
//  UIRectEdgeTest.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 18/11/21.
//
//

import Foundation
import Quick
import Nimble
import ADUtils

class UIRectEdgeTest: QuickSpec {

    override func spec() {

        describe("horizontal edges") {
            let horizontalEdge: UIRectEdge = .horizontal
            it("should contain horizontal values") {
                expect(horizontalEdge).to(contain(.left))
                expect(horizontalEdge).to(contain(.right))
            }

            it("should not contain vertical values") {
                expect(horizontalEdge).toNot(contain(.bottom))
                expect(horizontalEdge).toNot(contain(.top))
            }
        }

        describe("vertical edges") {
            let verticalEdge: UIRectEdge = .vertical
            it("should contain vertical values") {
                expect(verticalEdge).to(contain(.bottom))
                expect(verticalEdge).to(contain(.top))
            }

            it("should not contain horizontal values") {
                expect(verticalEdge).toNot(contain(.left))
                expect(verticalEdge).toNot(contain(.right))
            }
        }
    }

}
