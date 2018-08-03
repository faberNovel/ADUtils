//
//  UIEdgeInsetsTest.swift
//  ADUtils
//
//  Created by Pierre Felgines on 23/11/16.
//
//

import Foundation
import Quick
import Nimble
import ADUtils

class UIEdgeInsetsTest: QuickSpec {

    override func spec() {
        it("should init insets with only one value") {
            let value: CGFloat = 10
            let inset = UIEdgeInsets(value: value)
            expect(inset.left).to(equal(value))
            expect(inset.right).to(equal(value))
            expect(inset.top).to(equal(value))
            expect(inset.bottom).to(equal(value))
        }

        it("should init insets with horizontal and vertical values") {
            let horizontal: CGFloat = 2
            let vertical: CGFloat = 3
            let inset = UIEdgeInsets(horizontal: horizontal, vertical: vertical)
            expect(inset.left).to(equal(horizontal))
            expect(inset.right).to(equal(horizontal))
            expect(inset.top).to(equal(vertical))
            expect(inset.bottom).to(equal(vertical))
        }

        it("should compute horizontal and vertical properties correctly") {
            let left: CGFloat = 1
            let right: CGFloat = 2
            let top: CGFloat = 3
            let bottom: CGFloat = 4

            let inset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
            expect(inset.horizontal).to(equal(left + right))
            expect(inset.vertical).to(equal(top + bottom))
        }
    }

}
