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

class UINavigationItemBackItemTests: QuickSpec {

    override func spec() {

        it("should have an empty title") {
            // Given
            let item = UINavigationItem()
            item.ad_hideBackButtonTitle()

            // Then
            expect(item.backBarButtonItem?.title).to(beEmpty())
        }
    }
}
