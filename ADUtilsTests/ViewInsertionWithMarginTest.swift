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
import Nimble_Snapshots
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

    override func spec() {
        standardEdgesSpec()
        if #available(iOS 13, *) {
            directionalEdgesSpec()
        }
    }

    // MARK: - Private

    private func standardEdgesSpec() {

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
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithInsets"))
            }

            it("should pin top right with insets") {
                subview.ad_pinToSuperview(edges: [.top, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithInsets"))
            }

            it("should pin top left with insets") {
                subview.ad_pinToSuperview(edges: [.top, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithInsets"))
            }

            it("should pin bottom right with insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithInsets"))
            }

            it("should pin bottom left with insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithInsets"))
            }

            it("should pin all edges without insets") {
                subview.ad_pinToSuperview()
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithoutInsets"))
            }

            it("should pin top right without insets") {
                subview.ad_pinToSuperview(edges: [.top, .right])
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithoutInsets"))
            }

            it("should pin top left without insets") {
                subview.ad_pinToSuperview(edges: [.top, .left])
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithoutInsets"))
            }

            it("should pin bottom right without insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .right])
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithoutInsets"))
            }

            it("should pin bottom left without insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .left])
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithoutInsets"))
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
                expect(view).to(haveValidSnapshot(named: "CenterInSuperview"))
            }

            it("should center X in superview") {
                subview.ad_pinToSuperview(edges: [.top, .bottom])
                subview.ad_centerInSuperview(along: .horizontal)
                expect(view).to(haveValidSnapshot(named: "CenterXInSuperview"))
            }

            it("should center Y in superview") {
                subview.ad_pinToSuperview(edges: [.left, .right])
                subview.ad_centerInSuperview(along: .vertical)
                expect(view).to(haveValidSnapshot(named: "CenterYInSuperview"))
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
                expect(view).to(haveValidSnapshot(named: "ConstrainToSize"))
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
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomLeft"))
            }

            it("should constrain in superview pin bottom right") {
                subview.ad_pinToSuperview(edges: [.bottom, .right], insets: insets)
                subview.ad_constrainInSuperview(edges: [.top, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomRight"))
            }

            it("should constrain in superview pin top left") {
                subview.ad_pinToSuperview(edges: [.top, .left], insets: insets)
                subview.ad_constrainInSuperview(edges: [.bottom, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopLeft"))
            }

            it("should constrain in superview pin top right") {
                subview.ad_pinToSuperview(edges: [.top, .right], insets: insets)
                subview.ad_constrainInSuperview(edges: [.bottom, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopRight"))
            }

            it("should constrain in superview") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview()
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperview"))
            }

            it("should constrain in superview with insets") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(insets: UIEdgeInsets(value: 10.0))
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithInsets"))
            }

            it("should constrain in superview with left edge") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(edges: [.left])
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithLeftEdge"))
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
                    expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinBottomLeft"))
                }

                it("should constrain in superview pin bottom right") {
                    subview.ad_pinToSuperviewSafeAreaLayoutGuide(edges: [.bottom, .right], insets: insets)
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.top, .left], insets: insets)
                    expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinBottomRight"))
                }

                it("should constrain in superview pin top left") {
                    subview.ad_pinToSuperviewSafeAreaLayoutGuide(edges: [.top, .left], insets: insets)
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.bottom, .right], insets: insets)
                    expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinTopLeft"))
                }

                it("should constrain in superview pin top right") {
                    subview.ad_pinToSuperviewSafeAreaLayoutGuide(edges: [.top, .right], insets: insets)
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.bottom, .left], insets: insets)
                    expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinTopRight"))
                }

                it("should constrain in superview") {
                    subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide()
                    expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeArea"))
                }

                it("should constrain in superview with insets") {
                    subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(insets: UIEdgeInsets(value: 100))
                    expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaWithInsets"))
                }

                it("should constrain in superview with left edge") {
                    subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                    subview.ad_constrainInSuperviewSafeAreaLayoutGuide(edges: [.left])
                    expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaWithLeftEdge"))
                }
            }
        }
    }

    @available(iOS 13.0, *)
    @available(tvOSApplicationExtension 13.0, *)
    private func directionalEdgesSpec() {

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
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithInsetsRTLForced"))
            }

            it("should pin top right with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .trailing], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithInsetsRTLForced"))
            }

            it("should pin top left with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .leading], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithInsetsRTLForced"))
            }

            it("should pin bottom right with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .trailing], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithInsetsRTLForced"))
            }

            it("should pin bottom left with insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .leading], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithInsetsRTLForced"))
            }

            it("should pin all edges without insets") {
                subview.ad_pinToSuperview()
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithoutInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithoutInsetsRTLForced"))
            }

            it("should pin top right without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .trailing])
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithoutInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithoutInsetsRTLForced"))
            }

            it("should pin top left without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .leading])
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithoutInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithoutInsetsRTLForced"))
            }

            it("should pin bottom right without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .trailing])
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithoutInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithoutInsetsRTLForced"))
            }

            it("should pin bottom left without insets") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .leading])
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithoutInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithoutInsetsRTLForced"))
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
                expect(view).to(haveValidSnapshot(named: "CenterInSuperview"))
                expect(view).to(haveValidSnapshot(named: "CenterInSuperviewRTLForced"))
            }

            it("should center X in superview") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .bottom])
                subview.ad_centerInSuperview(along: .horizontal)
                expect(view).to(haveValidSnapshot(named: "CenterXInSuperview"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "CenterXInSuperviewRTLForced"))
            }

            it("should center Y in superview") {
                subview.ad_pinToSuperview(directionalEdges: [.leading, .trailing])
                subview.ad_centerInSuperview(along: .vertical)
                expect(view).to(haveValidSnapshot(named: "CenterYInSuperview"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "CenterYInSuperviewRTLForced"))
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
                expect(view).to(haveValidSnapshot(named: "ConstrainToSize"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainToSizeRTLForced"))
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
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomLeft"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomLeftRTLForced"))
            }

            it("should constrain in superview pin bottom right") {
                subview.ad_pinToSuperview(directionalEdges: [.bottom, .trailing], insets: insets)
                subview.ad_constrainInSuperview(directionalEdges: [.top, .leading], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomRight"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomRightRTLForced"))
            }

            it("should constrain in superview pin top left") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .leading], insets: insets)
                subview.ad_constrainInSuperview(directionalEdges: [.bottom, .trailing], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopLeft"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopLeftRTLForced"))
            }

            it("should constrain in superview pin top right") {
                subview.ad_pinToSuperview(directionalEdges: [.top, .trailing], insets: insets)
                subview.ad_constrainInSuperview(directionalEdges: [.bottom, .leading], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopRight"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopRightRTLForced"))
            }

            it("should constrain in superview") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview()
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperview"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewRTLForced"))
            }

            it("should constrain in superview with insets") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(insets: NSDirectionalEdgeInsets(value: 10.0))
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithInsets"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithInsetsRTLForced"))
            }

            it("should constrain in superview with left edge") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(directionalEdges: [.leading])
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithLeftEdge"))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithLeftEdgeRTLForced"))
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
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinBottomLeft"))
            }

            it("should constrain in superview pin bottom trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.bottom, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinBottomRight"))
            }

            it("should constrain in superview pin top leading") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .trailing],
                    insets: insets
                )
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinTopLeft"))
            }

            it("should constrain in superview pin top trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .leading],
                    insets: insets
                )
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinTopRight"))
            }

            it("should constrain in superview with directional insets") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(insets: NSDirectionalEdgeInsets(value: 100))
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaWithInsets"))
            }

            it("should constrain in superview with leading edge") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.leading])
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaWithLeftEdge"))
            }

            it("should constrain in superview pin bottom leading") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.bottom, .leading], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .trailing], insets: insets)
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinBottomLeading"))
            }

            it("should constrain in superview pin bottom trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.bottom, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinBottomTrailing"))
            }

            it("should constrain in superview pin top leading") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .leading], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .trailing],
                    insets: insets
                )
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinTopLeading"))
            }

            it("should constrain in superview pin top trailing") {
                subview.ad_pinToSuperviewSafeAreaLayoutGuide(directionalEdges: [.top, .trailing], insets: insets)
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(
                    directionalEdges: [.bottom, .leading],
                    insets: insets
                )
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaPinTopTrailing"))
            }

            it("should constrain in superview with directional insets") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(insets: NSDirectionalEdgeInsets(value: 100))
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaWithInsets"))
            }

            it("should constrain in superview with leading edge") {
                subview.ad_centerInSuperviewSafeAreaLayoutGuide()
                subview.ad_constrainInSuperviewSafeAreaLayoutGuide(directionalEdges: [.leading])
                view.semanticContentAttribute = .forceRightToLeft
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewSafeAreaWithLeftEdge"))
            }
        }
    }
}
