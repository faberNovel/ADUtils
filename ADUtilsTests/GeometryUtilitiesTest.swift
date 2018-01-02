//
//  GeometryUtilitiesTest.swift
//  ADUtilsTests
//
//  Created by Gaétan Zanella on 02/01/2018.
//

import Foundation
import Quick
import Nimble
import ADUtils

class GeometryUtilitiesTest : QuickSpec {
    override func spec() {
        it("should update the origin of rectangle") {
            var rect = CGRect(x: 20, y: 20, width: 40, height: 60)
            rect.center = CGPoint(x: 0, y: 0)
            expect(rect.origin).to(equal(CGPoint(x: -20, y: -30)))
            rect.origin = CGPoint(x: 10, y: 10)
            expect(rect.center).to(equal(CGPoint(x: 30, y: 40)))
        }
    }
}
