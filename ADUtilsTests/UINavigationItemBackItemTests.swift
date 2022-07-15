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
            if #available(iOS 14.0, *) {
                expect(item.backButtonTitle).to(beNil())
            } else {
                expect(item.backBarButtonItem?.title).to(beEmpty())
            }
        }
    }

}
