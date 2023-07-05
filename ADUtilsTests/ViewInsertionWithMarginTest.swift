//
//  ViewInsertionWithMarginTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation

import Foundation
import Nimble
import SnapshotTesting
import Quick
import ADUtils
@testable import ADUtilsApp

class IntrinsicContentSizeView : UIView {

    private var contentSize: CGSize = CGSize.zero

    convenience init(contentSize: CGSize) {
        self.init()
        self.contentSize = contentSize
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

class ViewInsertionWithMargin: QuickSpec {

    override class func spec() {
        standardEdgesSpec()
        if #available(iOS 13, *) {
            directionalEdgesSpec()
        }
    }

    // MARK: - Private

    private class func standardEdgesSpec() {

        describe("Pin to superview") {

            let insets = UIEdgeInsets(top: 12.0, left: 13.0, bottom: 20.0, right: 45.0)
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should pin all edges with insets") {
                subview.ad_pinToSuperview(insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinAllEdgesWithInsets")
            }

            it("should pin top right with insets") {
                subview.ad_pinToSuperview(edges: [.top, .right], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinTopRightEdgesWithInsets")
            }

            it("should pin top left with insets") {
                subview.ad_pinToSuperview(edges: [.top, .left], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinTopLeftEdgesWithInsets")
            }

            it("should pin bottom right with insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .right], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinBottomRightEdgesWithInsets")
            }

            it("should pin bottom left with insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .left], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinBottomLeftEdgesWithInsets")
            }

            it("should pin all edges without insets") {
                subview.ad_pinToSuperview()
                assertSnapshot(matching: view, as: .image, named: "PinAllEdgesWithoutInsets")
            }

            it("should pin top right without insets") {
                subview.ad_pinToSuperview(edges: [.top, .right])
                assertSnapshot(matching: view, as: .image, named: "PinTopRightEdgesWithoutInsets")
            }

            it("should pin top left without insets") {
                subview.ad_pinToSuperview(edges: [.top, .left])
                assertSnapshot(matching: view, as: .image, named: "PinTopLeftEdgesWithoutInsets")
            }

            it("should pin bottom right without insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .right])
                assertSnapshot(matching: view, as: .image, named: "PinBottomRightEdgesWithoutInsets")
            }

            it("should pin bottom left without insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .left])
                assertSnapshot(matching: view, as: .image, named: "PinBottomLeftEdgesWithoutInsets")
            }
        }

        describe("Center in superview") {
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should center in superview") {
                subview.ad_centerInSuperview()
                assertSnapshot(matching: view, as: .image, named: "CenterInSuperview")
            }

            it("should center X in superview") {
                subview.ad_pinToSuperview(edges: [.top, .bottom])
                subview.ad_centerInSuperview(along: .horizontal)
                assertSnapshot(matching: view, as: .image, named: "CenterXInSuperview")
            }

            it("should center Y in superview") {
                subview.ad_pinToSuperview(edges: [.left, .right])
                subview.ad_centerInSuperview(along: .vertical)
                assertSnapshot(matching: view, as: .image, named: "CenterYInSuperview")
            }
        }

        describe("Constrain to size") {
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = UIView()
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should constrain to size") {
                subview.ad_constrain(to: CGSize(width: 50, height: 50))
                subview.ad_pinToSuperview(edges: [.top, .left])
                assertSnapshot(matching: view, as: .image, named: "ConstrainToSize")
            }
        }

        describe("Constrain in superview") {
            var view: UIView!
            var subview: UIView!
            let insets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 30.0, right: 40.0)

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 300, height: 300))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should constrain in superview pin bottom left") {
                subview.ad_pinToSuperview(edges: [.bottom, .left], insets: insets)
                subview.ad_constrainInSuperview(edges: [.top, .right], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinBottomLeft")
            }

            it("should constrain in superview pin bottom right") {
                subview.ad_pinToSuperview(edges: [.bottom, .right], insets: insets)
                subview.ad_constrainInSuperview(edges: [.top, .left], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinBottomRight")
            }

            it("should constrain in superview pin top left") {
                subview.ad_pinToSuperview(edges: [.top, .left], insets: insets)
                subview.ad_constrainInSuperview(edges: [.bottom, .right], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinTopLeft")
            }

            it("should constrain in superview pin top right") {
                subview.ad_pinToSuperview(edges: [.top, .right], insets: insets)
                subview.ad_constrainInSuperview(edges: [.bottom, .left], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinTopRight")
            }

            it("should constrain in superview") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview()
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperview")
            }

            it("should constrain in superview with insets") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(insets: UIEdgeInsets(value: 10.0))
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewWithInsets")
            }

            it("should constrain in superview with left edge") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(edges: [.left])
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewWithLeftEdge")
            }
        }

        if #available(iOS 11.0, *) {
            describe("Constrain in superview's safe area layout guide") {
                var viewController: UIViewController!
                var view: UIView {
                    return viewController.view
                }
                var subview: UIView!
                let insets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 30.0, right: 40.0)

                beforeEach {
                    viewController = UIViewController()
                    viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 40, left: 30, bottom: 20, right: 10)
                    viewController.view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                    view.backgroundColor = UIColor.white
                    subview = IntrinsicContentSizeView(contentSize: CGSize(width: 500, height: 500))
                    subview.backgroundColor = UIColor.red
                    view.addSubview(subview)

                    //(Benjamin Lavialle) 2020-03-19 Adding the view controller to a window is required to have
                    // safe area insets. The snapshots are then device agnostic.
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }

                it("should constrain in superview pin bottom left") {
                    subview.ad_pinToSuperviewSafeAreaLayoutGuide(edges: [.bottom, .left], insets: insets)
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.top, .right], insets: insets)
                    assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinBottomLeft")
                }

                it("should constrain in superview pin bottom right") {
                    subview.ad_pinToSuperviewSafeAreaLayoutGuide(edges: [.bottom, .right], insets: insets)
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.top, .left], insets: insets)
                    assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinBottomRight")
                }

                it("should constrain in superview pin top left") {
                    subview.ad_pinToSuperviewSafeAreaLayoutGuide(edges: [.top, .left], insets: insets)
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.bottom, .right], insets: insets)
                    assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinTopLeft")
                }

                it("should constrain in superview pin top right") {
                    subview.ad_pinToSuperviewSafeAreaLayoutGuide(edges: [.top, .right], insets: insets)
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.bottom, .left], insets: insets)
                    assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinTopRight")
                }

                it("should constrain in superview") {
                    subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide()
                    assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeArea")
                }

                it("should constrain in superview with insets") {
                    subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(insets: UIEdgeInsets(value: 100))
                    assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaWithInsets")
                }

                it("should constrain in superview with left edge") {
                    subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.left])
                    assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaWithLeftEdge")
                }
            }
        }
    }

    @available(iOS 13.0, *)
    @available(tvOSApplicationExtension 13.0, *)
    private static func directionalEdgesSpec() {

        describe("Pin to superview") {

            let insets = NSDirectionalEdgeInsets(top: 12.0, leading: 13.0, bottom: 20.0, trailing: 45.0)
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should pin all edges with insets") {
                subview.ad_pinToSuperview(insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinAllEdgesWithInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinAllEdgesWithInsetsRTLForced")
            }

            it("should pin top right with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .trailing], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinTopRightEdgesWithInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinTopRightEdgesWithInsetsRTLForced")
            }

            it("should pin top left with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .leading], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinTopLeftEdgesWithInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinTopLeftEdgesWithInsetsRTLForced")
            }

            it("should pin bottom right with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .trailing], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinBottomRightEdgesWithInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinBottomRightEdgesWithInsetsRTLForced")
            }

            it("should pin bottom left with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .leading], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "PinBottomLeftEdgesWithInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinBottomLeftEdgesWithInsetsRTLForced")
            }

            it("should pin all edges without insets") {
                subview.ad_pinToSuperview()
                assertSnapshot(matching: view, as: .image, named: "PinAllEdgesWithoutInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinAllEdgesWithoutInsetsRTLForced")
            }

            it("should pin top right without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .trailing])
                assertSnapshot(matching: view, as: .image, named: "PinTopRightEdgesWithoutInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinTopRightEdgesWithoutInsetsRTLForced")
            }

            it("should pin top left without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .leading])
                assertSnapshot(matching: view, as: .image, named: "PinTopLeftEdgesWithoutInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinTopLeftEdgesWithoutInsetsRTLForced")
            }

            it("should pin bottom right without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .trailing])
                assertSnapshot(matching: view, as: .image, named: "PinBottomRightEdgesWithoutInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinBottomRightEdgesWithoutInsetsRTLForced")
            }

            it("should pin bottom left without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .leading])
                assertSnapshot(matching: view, as: .image, named: "PinBottomLeftEdgesWithoutInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "PinBottomLeftEdgesWithoutInsetsRTLForced")
            }
        }

        describe("Center in superview") {
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should center in superview") {
                subview.ad_centerInSuperview()
                assertSnapshot(matching: view, as: .image, named: "CenterInSuperview")
                assertSnapshot(matching: view, as: .image, named: "CenterInSuperviewRTLForced")
            }

            it("should center X in superview") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .bottom])
                subview.ad_centerInSuperview(along: .horizontal)
                assertSnapshot(matching: view, as: .image, named: "CenterXInSuperview")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "CenterXInSuperviewRTLForced")
            }

            it("should center Y in superview") {
                subview.ad_pinToSuperview(directionalEdges: [.leading, .trailing])
                subview.ad_centerInSuperview(along: .vertical)
                assertSnapshot(matching: view, as: .image, named: "CenterYInSuperview")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "CenterYInSuperviewRTLForced")
            }
        }

        describe("Constrain to size") {
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = UIView()
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should constrain to size") {
                subview.ad_constrain(to: CGSize(width: 50, height: 50))
                subview.ad_pinToSuperview(directionalEdges: [.top, .leading])
                assertSnapshot(matching: view, as: .image, named: "ConstrainToSize")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainToSizeRTLForced")
            }
        }

        describe("Constrain in superview") {
            var view: UIView!
            var subview: UIView!
            let insets = NSDirectionalEdgeInsets(top: 10.0, leading: 20.0, bottom: 30.0, trailing: 40.0)

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 300, height: 300))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should constrain in superview pin bottom left") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .leading], insets: insets)
                subview.ad_constrainInSuperview(directionalEdges: [.top, .trailing], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinBottomLeft")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinBottomLeftRTLForced")
            }

            it("should constrain in superview pin bottom right") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .trailing], insets: insets)
                subview.ad_constrainInSuperview(directionalEdges: [.top, .leading], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinBottomRight")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinBottomRightRTLForced")
            }

            it("should constrain in superview pin top left") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .leading], insets: insets)
                subview.ad_constrainInSuperview(directionalEdges: [.bottom, .trailing], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinTopLeft")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinTopLeftRTLForced")
            }

            it("should constrain in superview pin top right") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .trailing], insets: insets)
                subview.ad_constrainInSuperview(directionalEdges: [.bottom, .leading], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinTopRight")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewPinTopRightRTLForced")
            }

            it("should constrain in superview") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview()
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperview")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewRTLForced")
            }

            it("should constrain in superview with insets") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(insets: NSDirectionalEdgeInsets(value: 10.0))
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewWithInsets")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewWithInsetsRTLForced")
            }

            it("should constrain in superview with left edge") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(directionalEdges: [.leading])
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewWithLeftEdge")
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewWithLeftEdgeRTLForced")
            }
        }

        describe("Constrain in superview's safe area layout guide with directional edges") {
            var viewController: UIViewController!
            var view: UIView {
                return viewController.view
            }
            var subview: UIView!
            let insets = NSDirectionalEdgeInsets(top: 10.0, leading: 20.0, bottom: 30.0, trailing: 40.0)

            beforeEach {
                viewController = UIViewController()
                viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 40, left: 30, bottom: 20, right: 10)
                viewController.view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 500, height: 500))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)

                //(Benjamin Lavialle) 2020-03-19 Adding the view controller to a window is required to have
                // safe area insets. The snapshots are then device agnostic.
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }

            it("should constrain in superview pin bottom leading") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.bottom, .leading], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .trailing], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinBottomLeft")
            }

            it("should constrain in superview pin bottom trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.bottom, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinBottomRight")
            }

            it("should constrain in superview pin top leading") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .trailing],
                    insets: insets
                )
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinTopLeft")
            }

            it("should constrain in superview pin top trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .leading],
                    insets: insets
                )
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinTopRight")
            }

            it("should constrain in superview with directional insets") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(insets: NSDirectionalEdgeInsets(value: 100))
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaWithInsets")
            }

            it("should constrain in superview with leading edge") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.leading])
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaWithLeftEdge")
            }

            it("should constrain in superview pin bottom leading") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.bottom, .leading], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .trailing], insets: insets)
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinBottomLeading")
            }

            it("should constrain in superview pin bottom trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.bottom, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinBottomTrailing")
            }

            it("should constrain in superview pin top leading") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .trailing],
                    insets: insets
                )
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinTopLeading")
            }

            it("should constrain in superview pin top trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .leading],
                    insets: insets
                )
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaPinTopTrailing")
            }

            it("should constrain in superview with directional insets") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(insets: NSDirectionalEdgeInsets(value: 100))
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaWithInsets")
            }

            it("should constrain in superview with leading edge") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.leading])
                view.semanticContentAttribute = .forceRightToLeft
                assertSnapshot(matching: view, as: .image, named: "ConstrainInSuperviewSafeAreaWithLeftEdge")
            }
        }
    }
}
