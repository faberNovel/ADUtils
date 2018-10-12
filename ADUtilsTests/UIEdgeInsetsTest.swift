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
            expect(inset.totalHorizontal).to(equal(left + right))
            expect(inset.totalVertical).to(equal(top + bottom))
        }

        it("should compute single edge properties correctly") {
            let left: CGFloat = 1
            let right: CGFloat = 2
            let top: CGFloat = 3
            let bottom: CGFloat = 4

            let leftInset = UIEdgeInsets(left: left)
            let rightInset = UIEdgeInsets(right: right)
            let topInset = UIEdgeInsets(top: top)
            let bottomInset = UIEdgeInsets(bottom: bottom)

            expect(leftInset).to(equal(UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)))
            expect(rightInset).to(equal(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: right)))
            expect(topInset).to(equal(UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)))
            expect(bottomInset).to(equal(UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)))
        }
    }

}
