//
//  ChildInsertionTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation
import Nimble
import Quick
import ADUtils
@testable import ADUtilsApp

class ChildInsertionTest: QuickSpec {

    override func spec() {
        it("should insert a view controller in a subview") {
            let viewController = UIViewController()
            let child = UIViewController()
            viewController.ad_insert(child: child, in: viewController.view)

            expect(viewController.children).to(equal([child]))
            let viewControllerSubviews: [UIView] = viewController.view.subviews
            let views: [UIView] = [child.view]
            expect(viewControllerSubviews).to(equal(views))

            viewController.view.frame = CGRect(x: 0.0, y: 0.0, width: 230.0, height: 400.0)
            viewController.view.layoutIfNeeded()

            expect(viewController.view.bounds).to(equal(child.view.bounds))

            viewController.ad_remove(child: child)

            expect(viewController.children).to(beEmpty())
            expect(viewController.view.subviews).to(beEmpty())
        }

        it("should fail to insert a view controller in a subview") {
            let view = UIView()
            let viewController = UIViewController()
            let child = UIViewController()
            viewController.ad_insert(child: child, in: view)
            expect(child.parent).to(beNil())
        }

        it("should insert a view controller in a layoutGuide") {
            let viewController = UIViewController()
            let child = UIViewController()
            let layoutGuide = UILayoutGuide()
            viewController.view.addLayoutGuide(layoutGuide)
            layoutGuide.ad_pinToOwningView()
            viewController.ad_insert(child: child, in: layoutGuide)

            expect(viewController.children).to(equal([child]))
            let viewControllerSubviews: [UIView] = viewController.view.subviews
            let views: [UIView] = [child.view]
            expect(viewControllerSubviews).to(equal(views))

            viewController.view.frame = CGRect(x: 0.0, y: 0.0, width: 230.0, height: 400.0)
            viewController.view.layoutIfNeeded()

            expect(viewController.view.bounds).to(equal(child.view.bounds))

            viewController.ad_remove(child: child)

            expect(viewController.children).to(beEmpty())
            expect(viewController.view.subviews).to(beEmpty())
        }

        it("should fail to insert a view controller in a layoutGuide") {
            let viewController = UIViewController()
            let child = UIViewController()
            let layoutGuide = UILayoutGuide()
            viewController.ad_insert(child: child, in: layoutGuide)
            expect(viewController.children).to(equal([]))
        }
    }
}
