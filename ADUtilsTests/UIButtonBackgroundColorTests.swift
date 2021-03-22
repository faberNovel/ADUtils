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
import Nimble_Snapshots

class UIButtonBackgroundColorTests: QuickSpec {

    override func spec() {

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
            expect(button).to(haveValidSnapshot(named: "UIButtonBackgroundColorNormal"))
            button.isEnabled = false
            expect(button).to(haveValidSnapshot(named: "UIButtonBackgroundColorDisabled"))

            button.ad_setBackgroundColor(nil, for: .disabled)
            expect(button).to(haveValidSnapshot(named: "UIButtonBackgroundColorDisabledNoColor"))
        }
    }
}
