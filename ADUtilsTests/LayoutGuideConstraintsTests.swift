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

        describe("Center in layout guide") {
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                view.layoutMargins = UIEdgeInsets(value: 10.0)
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should center in layout guide") {
                subview.ad_center(in: view.layoutMarginsGuide)
                // ???: (Pierre Felgines) 08/10/2018 Intrinsic content size is not enough here
                subview.ad_constrain(to: subview.intrinsicContentSize)
                expect(view).to(haveValidSnapshot(named: "CenterInLayoutGuide"))
            }

            it("should center X in layout guide") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.top, .bottom])
                subview.ad_center(in: view.layoutMarginsGuide, along: .horizontal)
                expect(view).to(haveValidSnapshot(named: "CenterXInLayoutGuide"))
            }

            it("should center Y in layout guide") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.left, .right])
                subview.ad_center(in: view.layoutMarginsGuide, along: .vertical)
                expect(view).to(haveValidSnapshot(named: "CenterYInLayoutGuide"))
            }
        }

        describe("Constrain in layout guide") {
            var view: UIView!
            var subview: UIView!
            let insets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 30.0, right: 40.0)

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.layoutMargins = UIEdgeInsets(value: 10.0)
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 300, height: 300))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should constrain in layout guide pin bottom left") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.bottom, .left], insets: insets)
                subview.ad_constrain(in: view.layoutMarginsGuide, edges: [.top, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInLayoutGuidePinBottomLeft"))
            }

            it("should constrain in layout guide pin bottom right") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.bottom, .right], insets: insets)
                subview.ad_constrain(in: view.layoutMarginsGuide, edges: [.top, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInLayoutGuidePinBottomRight"))
            }

            it("should constrain in layout guide top left") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.top, .left], insets: insets)
                subview.ad_constrain(in: view.layoutMarginsGuide, edges: [.bottom, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInLayoutGuidePinTopLeft"))
            }

            it("should constrain in layout guide pin top right") {
                subview.ad_pin(to: view.layoutMarginsGuide, edges: [.top, .right], insets: insets)
                subview.ad_constrain(in: view.layoutMarginsGuide, edges: [.bottom, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInLayoutGuidePinTopRight"))
            }

            it("should constrain in layout guide") {
                subview.ad_center(in: view.layoutMarginsGuide)
                subview.ad_constrain(in: view.layoutMarginsGuide)
                expect(view).to(haveValidSnapshot(named: "ConstrainInLayoutGuide"))
            }

            it("should constrain in layout guide with insets") {
                subview.ad_center(in: view.layoutMarginsGuide)
                // ???: (Pierre Felgines) 08/10/2018 Intrinsic content size is not enough here
                subview.ad_constrain(to: subview.intrinsicContentSize, priority: .defaultLow)
                subview.ad_constrain(in: view.layoutMarginsGuide, insets: UIEdgeInsets(value: 10.0))
                expect(view).to(haveValidSnapshot(named: "ConstrainInLayoutGuideWithInsets"))
            }

            it("should constrain in layout guide with left edge") {
                subview.ad_center(in: view.layoutMarginsGuide)
                // ???: (Pierre Felgines) 08/10/2018 Intrinsic content size is not enough here
                subview.ad_constrain(to: subview.intrinsicContentSize, priority: .defaultLow)
                subview.ad_constrain(in: view.layoutMarginsGuide, edges: [.left])
                expect(view).to(haveValidSnapshot(named: "ConstrainInLayoutGuideWithLeftEdge"))
            }
        }
    }
}

