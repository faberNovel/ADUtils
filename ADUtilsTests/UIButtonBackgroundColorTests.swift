//
//  UIButtonBackgroundColorTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 16/02/2021.
//

import Foundation
import Nimble
import Quick
import ADUtils
import SnapshotTesting

@MainActor
class UIButtonBackgroundColorTests: QuickSpec {

    override class func spec() {

        it("should have correct snapshot") {
            // Given
            let button = UIButton(type: .custom)
            button.frame = CGRect(
                origin: .zero,
                size: CGSize(width: 20.0, height: 10.0)
            )

            // When
            button.ad_setBackgroundColor(.red, for: .normal)
            button.ad_setBackgroundColor(.green, for: .disabled)

            // Then
            assertSnapshot(matching: button, as: .image, named: "UIButtonBackgroundColorNormal")
            button.isEnabled = false
            assertSnapshot(matching: button, as: .image, named: "UIButtonBackgroundColorDisabled")

            button.ad_setBackgroundColor(nil, for: .disabled)
            assertSnapshot(matching: button, as: .image, named: "UIButtonBackgroundColorDisabledNoColor")
        }
    }
}
