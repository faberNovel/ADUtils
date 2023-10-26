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

class NSDirectionalRectEdgeTest: QuickSpec {

    override class func spec() {

        it("should only contain vertical values") {
            expect(NSDirectionalRectEdge.vertical).to(equal([.top, .bottom]))
        }

        it("should only contain horizontal values") {
            expect(NSDirectionalRectEdge.horizontal).to(equal([.trailing, .leading]))
        }
    }
}
