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
        it("should insert a view controller") {
            let viewController = UIViewController()
            let child = UIViewController()
            viewController.ad_insertChild(child, inSubview: viewController.view)

            expect(viewController.childViewControllers).to(equal([child]))
            let viewControllerSubviews: [UIView] = viewController.view.subviews
            let views: [UIView] = [child.view]
            expect(viewControllerSubviews).to(equal(views))

            viewController.view.frame = CGRect(x: 0.0, y: 0.0, width: 230.0, height: 400.0)
            viewController.view.layoutIfNeeded()

            expect(viewController.view.bounds).to(equal(child.view.bounds))

            viewController.ad_removeChild(child)

            expect(viewController.childViewControllers).to(beEmpty())
            expect(viewController.view.subviews).to(beEmpty())
        }
    }
    
}
