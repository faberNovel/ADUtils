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

    override class func spec() {

        it("should only contain vertical values") {
            expect(UIRectEdge.vertical).to(equal([.top, .bottom]))
        }

        it("should only contain horizontal values") {
            expect(UIRectEdge.horizontal).to(equal([.left, .right]))
        }
    }
}
