//
//  UIButtonContentEdgeInsetsTests.swift
//  ADUtilsTests
//
//  Created by Thomas Esterlin on 22/11/2021.
//

import Foundation
import UIKit
import Nimble
import Quick
import ADUtils
import Nimble_Snapshots

@available(iOS 13.0, *)
class UIButtonContentEdgeInsetsTests: QuickSpec {

    override func spec() {

        describe("Add insets to UIButton's title and image") {
            var view: UIView!
            var button: UIButton!
            let smallFont = UIFont(name: "HelveticaNeue", size: 12.0)

            beforeEach {
                view = UIView(frame: CGRect(x: 0, y: 0, width: 400.0, height: 400.0))
                button = UIButton()
                view.addSubview(button)
                button.ad_centerInSuperview()
                button.setTitle("Fabernovel", for: .normal)
                button.backgroundColor = .white
                button.setTitleColor(.systemBlue, for: .normal)
                button.titleLabel?.font = smallFont
            }


            it("should not have inset") {
                expect(button) == snapshot("UIButtonContentEdgeInsetsNoInset")
            }

            it("should have inset on top") {
                button.ad_setInsets(top: 5.0, bottom: 0.0, left: 0.0, right: 0.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsTopOnly")
            }

            it("should have inset on bottom") {
                button.ad_setInsets(top: 0.0, bottom: 5.0, left: 0.0, right: 0.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsBottomOnly")
            }

            it("should have inset on left") {
                button.ad_setInsets(top: 0.0, bottom: 0.0, left: 5.0, right: 0.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsLeftOnly")
            }

            it("should have inset on right") {
                button.ad_setInsets(top: 0.0, bottom: 0.0, left: 0.0, right: 5.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsRightOnly")
            }

            it("should have inset on top and right") {
                button.ad_setInsets(top: 5.0, bottom: 0.0, left: 0.0, right: 5.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsTopAndRight")
            }

            it("should have inset on bottom and left") {
                button.ad_setInsets(top: 0.0, bottom: 5.0, left: 5.0, right: 0.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsBottomAndLeft")
            }

            it("should have inset on every side") {
                button.ad_setInsets(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsEverySide")
            }

            it("should have vertical inset") {
                button.ad_setInsets(vertical: 5.0, horizontal: 0.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsVertical")
            }

            it("should have horizontal inset") {
                button.ad_setInsets(vertical: 0.0, horizontal: 5.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsHorizontal")
            }

            it("should have inset on every side") {
                button.ad_setInsets(vertical: 5.0, horizontal: 5.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsEverySide")
            }

            it("should have no inset between image and title") {
                button.setImage(UIImage(systemName: "faceid"), for: .normal)
                expect(button) == snapshot("UIButtonContentEdgeInsetsImageNoInset")
            }

            it("should have inset between image and title") {
                button.setImage(UIImage(systemName: "faceid"), for: .normal)
                button.ad_setInsets(vertical: 0.0, horizontal: 0.0, spaceBetweenImageAndTitle: 10.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsImageInset")
            }

            it("should have vertical inset and between image and title") {
                button.setImage(UIImage(systemName: "faceid"), for: .normal)
                button.ad_setInsets(vertical: 5.0, horizontal: 0.0, spaceBetweenImageAndTitle: 10.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsImageVerticalBetweenInset")
            }

            it("should have horizontal inset and between image and title") {
                button.setImage(UIImage(systemName: "faceid"), for: .normal)
                button.ad_setInsets(vertical: 0.0, horizontal: 5.0, spaceBetweenImageAndTitle: 10.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsImageHorizontalBetweenInset")
            }

            it("should have vertical and horizontal inset, and between image and title") {
                button.setImage(UIImage(systemName: "faceid"), for: .normal)
                button.ad_setInsets(vertical: 5.0, horizontal: 5.0, spaceBetweenImageAndTitle: 10.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsImageVerticalHorizontalBetweenInset")
            }

            it("should properly handle right to left layout") {
                button.semanticContentAttribute = .forceRightToLeft
                button.setImage(UIImage(systemName: "faceid"), for: .normal)
                button.ad_setInsets(vertical: 5.0, horizontal: 5.0, spaceBetweenImageAndTitle: 10.0)
                expect(button) == snapshot("UIButtonContentEdgeInsetsImageRightToLeftLayout")
            }
        }
        
    }
    
}
