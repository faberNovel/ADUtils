//
//  UINavigationItemBackItemTests.swift
//  ADUtilsTests
//
//  Created by Gaétan Zanella on 27/03/2020.
//

import Foundation
import Nimble
import Quick
import ADUtils

@MainActor
class UINavigationItemBackItemTests: QuickSpec {

    override class func spec() {

        it("should have an empty title") {
            // Given
            let item = UINavigationItem()
            item.ad_hideBackButtonTitle()

            // Then
            expect(item.backButtonTitle).to(beNil())
        }
    }

}
