//
//  NavigationControllerPopCompletionTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 04/05/2020.
//

import Foundation
import UIKit
import Nimble
import Quick
import ADUtils

class CompletionBehavior: Behavior<Bool> {

    override class func spec(_ context: @escaping () -> Bool) {
        var isAnimated: Bool!

        beforeEach {
            isAnimated = context()
        }

        it("should call completion once pop is done") {
            // Given
            let rootViewController = UIViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            let viewController = UIViewController()
            navigationController.pushViewController(viewController, animated: false)

            // When
            var completionCalled = false
            navigationController.ad_popViewController(animated: isAnimated) {
                completionCalled = true
            }

            // Then
            expect(completionCalled).toEventually(beTrue())
        }
    }
}

class NavigationControllerPopCompletionTests: QuickSpec {

    override func spec() {
        let isAnimated = true
        let isNotAnimated = false
        itBehavesLike(CompletionBehavior.self) { isAnimated }
        itBehavesLike(CompletionBehavior.self) { isNotAnimated }
    }
}
