//
//  NavigationControllerObserverTest.swift
//  ADUtils
//
//  Created by Pierre Felgines on 21/06/2017.
//
//

import Foundation
import Quick
import Nimble
import ADUtils

private class ObserverDelegate : NavigationControllerObserverDelegate {

    var observedViewControllers: [UIViewController] = []

    func navigationControllerObserver(_ observer: NavigationControllerObserver,
                                      didObservePopTransitionFor viewController: UIViewController) {
        observedViewControllers.append(viewController)
    }
}

class NavigationControllerObserverTest : QuickSpec {

    override func spec() {

        var navigationController = UINavigationController()
        var observer: NavigationControllerObserver!
        var observerDelegate: ObserverDelegate!

        beforeEach {
            let rootViewController = UIViewController()
            navigationController = UINavigationController(rootViewController: rootViewController)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            UIApplication.shared.keyWindow?.layer.speed = 100 // speed up animations

            observer = NavigationControllerObserver(navigationController: navigationController)
            observerDelegate = ObserverDelegate()
        }

        afterEach {
            UIApplication.shared.keyWindow?.layer.speed = 1 // reset default animations speed
        }

        it("should observe pop of view controller") {
            // Given
            let viewControllerToObserve = UIViewController()
            navigationController.pushViewController(viewControllerToObserve, animated: false)
            observer.observePopTransition(
                of: viewControllerToObserve,
                delegate: observerDelegate
            )

            waitUntil(timeout: 1.0) { done in
                // When
                navigationController.popViewController(animated: true)

                // We need to wait the end of the animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // Then
                    expect(navigationController.viewControllers.count).to(equal(1))
                    expect(observerDelegate.observedViewControllers).to(contain(viewControllerToObserve))
                    done()
                }
            }
        }

        it("should observe pop of multiple view controllers") {
            // Given
            let viewControllerToObserve1 = UIViewController()
            let viewControllerToObserve2 = UIViewController()
            navigationController.pushViewController(viewControllerToObserve1, animated: false)
            navigationController.pushViewController(viewControllerToObserve2, animated: false)

            let observerDelegate2 = ObserverDelegate()

            observer.observePopTransition(
                of: viewControllerToObserve1,
                delegate: observerDelegate
            )

            observer.observePopTransition(
                of: viewControllerToObserve2,
                delegate: observerDelegate2
            )

            waitUntil(timeout: 1.0) { done in
                // When
                navigationController.popViewController(animated: true)

                // We need to wait the end of the animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // Then
                    expect(navigationController.viewControllers.count).to(equal(2))
                    expect(observerDelegate2.observedViewControllers).to(contain(viewControllerToObserve2))

                    // When
                    navigationController.popViewController(animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        // Then
                        expect(navigationController.viewControllers.count).to(equal(1))
                        expect(observerDelegate.observedViewControllers).to(contain(viewControllerToObserve1))
                        done()
                    }
                }
            }
        }
    }
}
