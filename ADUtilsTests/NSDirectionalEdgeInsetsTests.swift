//
//  NSDirectionalEdgeInsetsTests.swift
//  ADUtilsTests
//
//  Created by Luc Cristol on 16/04/2020.
//

import Foundation
import Quick
import Nimble
import ADUtils

class NSDirectionalEdgeInsetsTests: QuickSpec {

    override class func spec() {
        it("should init directional insets with only one value") {
            let value: CGFloat = 10
            let inset = NSDirectionalEdgeInsets(value: value)
            expect(inset.leading).to(equal(value))
            expect(inset.trailing).to(equal(value))
            expect(inset.top).to(equal(value))
            expect(inset.bottom).to(equal(value))
        }

        it("should init directional insets with horizontal and vertical values") {
            let horizontal: CGFloat = 2
            let vertical: CGFloat = 3
            let inset = NSDirectionalEdgeInsets(horizontal: horizontal, vertical: vertical)
            expect(inset.leading).to(equal(horizontal))
            expect(inset.trailing).to(equal(horizontal))
            expect(inset.top).to(equal(vertical))
            expect(inset.bottom).to(equal(vertical))
        }

        it("should compute horizontal and vertical properties correctly") {
            let leading: CGFloat = 1
            let trailing: CGFloat = 2
            let top: CGFloat = 3
            let bottom: CGFloat = 4

            let inset = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
            expect(inset.totalHorizontal).to(equal(leading + trailing))
            expect(inset.totalVertical).to(equal(top + bottom))
        }

        it("should compute single edge properties correctly") {
            let leading: CGFloat = 1
            let trailing: CGFloat = 2
            let top: CGFloat = 3
            let bottom: CGFloat = 4

            let leadingInset = NSDirectionalEdgeInsets(leading: leading)
            let trailingInset = NSDirectionalEdgeInsets(trailing: trailing)
            let topInset = NSDirectionalEdgeInsets(top: top)
            let bottomInset = NSDirectionalEdgeInsets(bottom: bottom)

            expect(leadingInset).to(equal(NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: 0, trailing: 0)))
            expect(trailingInset).to(equal(NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: trailing)))
            expect(topInset).to(equal(NSDirectionalEdgeInsets(top: top, leading: 0, bottom: 0, trailing: 0)))
            expect(bottomInset).to(equal(NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: bottom, trailing: 0)))
        }
    }

}
