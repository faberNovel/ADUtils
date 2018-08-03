//
//  NibLoader.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation
import Nimble
import Quick
import ADUtils
@testable import ADUtilsApp

class NibLoaderTest: QuickSpec {

    override func spec() {
        it("should return a view") {
            let testView = TestView.ad_fromNib()
            expect(testView).toNot(beNil())
        }
    }

}
