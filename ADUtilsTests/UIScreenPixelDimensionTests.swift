//
//  UIScreenPixelDimensionTests.swift
//  ADUtilsTests
//
//  Created by Gaétan Zanella on 27/03/2020.
//

import Foundation
import Nimble
import Quick
import ADUtils

private class TestScreen: UIScreen {

    override var scale: CGFloat {
        return 2
    }
}

@MainActor
class UIScreenPixelDimensionTests: QuickSpec {

    override class func spec() {

        it("should have an empty title") {
            // Given
            let screen = TestScreen()

            // Then
            expect(screen.ad_pixelDimension).to(equal(0.5))
        }
    }
}
