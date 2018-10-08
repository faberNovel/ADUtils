//
//  LayoutGuideConstraintsTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 05/10/2018.
//

import Foundation
import Nimble
import Nimble_Snapshots
import Quick
import ADUtils

class LayoutGuideConstraintsTests: QuickSpec {

    override func spec() {

        describe("Pin to layout guide") {

            let insets = UIEdgeInsets(top: 12.0, left: 13.0, bottom: 20.0, right: 45.0)
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.layoutMargins = UIEdgeInsets(value: 10.0)
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should pin all edges no insets") {
                subview.ad_pin(to: view.layoutMarginsGuide)
                expect(view).to(haveValidSnapshot(named: "PinToLayoutGuideAllEdgesNoInsets"))
            }

            it("should pin all edges with insets") {
                subview.ad_pin(to: view.layoutMarginsGuide, insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinToLayoutGuideAllEdgesWithInsets"))
            }

            it("should pin top left edges no insets") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.top, .left])
                expect(view).to(haveValidSnapshot(named: "PinToLayoutGuideTopLeftEdgesNoInsets"))
            }

            it("should pin top left edges with insets") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.top, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinToLayoutGuideTopLeftEdgesWithInsets"))
            }

            it("should have no effet with wrong layout guide") {
                let extraView = UIView()
                subview.ad_pin(to: extraView.layoutMarginsGuide)
                expect(view).to(haveValidSnapshot(named: "PinToLayoutGuideNoSubview"))
            }

            it("should pin top left with high priorities") {
                let topConstraint = subview.topAnchor
                    .constraint(equalTo: view.layoutMarginsGuide.topAnchor)
                topConstraint.priority = .defaultLow
                topConstraint.isActive = true
                let leftConstraint = subview.leftAnchor
                    .constraint(equalTo: view.layoutMarginsGuide.leftAnchor)
                leftConstraint.priority = .defaultLow
                leftConstraint.isActive = true
                subview.ad_pin(
                    to: view.layoutMarginsGuide,
                    edges: [.top, .left],
                    insets: insets,
                    priority: .defaultHigh
                )
                expect(view).to(haveValidSnapshot(named: "PinToLayoutGuideTopLeftEdgesHighPriority"))
            }
        }
    }
}

