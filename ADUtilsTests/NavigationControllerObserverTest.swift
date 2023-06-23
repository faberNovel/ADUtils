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

private class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    var willShowViewControllers: [UIViewController] = []
    var didShowViewControllers: [UIViewController] = []

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        willShowViewControllers.append(viewController)
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        didShowViewControllers.append(viewController)
    }
}

class NavigationControllerObserverTest : QuickSpec {

    override class func spec() {

        let rootViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        var observer: NavigationControllerObserver!
        var observerDelegate: ObserverDelegate!

        beforeSuite {
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            UIApplication.shared.keyWindow?.layer.speed = 100 // speed up animations
            let viewController = UIViewController()
            navigationController.pushViewController(viewController, animated: false)
            waitUntil(timeout: .seconds(1)) { done in
                navigationController.popViewController(animated: true)
                // We need to wait the end of the animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    done()
                }
            }
        }

        afterSuite {
            UIApplication.shared.keyWindow?.layer.speed = 1 // reset default animations speed
        }

        beforeEach {
            navigationController.popToRootViewController(animated: false)

            observer = NavigationControllerObserver(navigationController: navigationController)
            observerDelegate = ObserverDelegate()
        }

        it("should observe pop of view controller") {
            // Given
            let viewControllerToObserve = UIViewController()
            navigationController.pushViewController(viewControllerToObserve, animated: false)
            observer.observePopTransition(
                of: viewControllerToObserve,
                delegate: observerDelegate
            )

            waitUntil(timeout: .seconds(1)) { done in
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

            waitUntil(timeout: .seconds(1)) { done in
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

        let removeObserverTest = { (removeObserverAction: @escaping (UIViewController) -> Void) in
            // Given
            let viewControllerToObserve = UIViewController()
            navigationController.pushViewController(viewControllerToObserve, animated: false)
            observer.observePopTransition(
                of: viewControllerToObserve,
                delegate: observerDelegate
            )

            waitUntil(timeout: .seconds(1)) { done in
                // When
                removeObserverAction(viewControllerToObserve)
                navigationController.popViewController(animated: true)

                // We need to wait the end of the animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // Then
                    expect(navigationController.viewControllers.count).to(equal(1))
                    expect(observerDelegate.observedViewControllers).to(beEmpty())
                    done()
                }
            }
        }

        it("should stop observing pop of view controller (with viewController)") {
            removeObserverTest { viewControllerToObserve in
                observer.removeDelegate(observing: viewControllerToObserve)
            }
        }

        it("should stop observing pop of view controller (with delegate)") {
            removeObserverTest { _ in
                observer.remove(observerDelegate)
            }
        }

        it("should stop observing pop of all view controllers") {
            removeObserverTest { _ in
                observer.removeAllDelegates()
            }
        }

        it("should forward navigation controller delegate methods") {
            // Given
            let viewControllerToObserve = UIViewController()
            navigationController.pushViewController(viewControllerToObserve, animated: false)
            observer.observePopTransition(
                of: viewControllerToObserve,
                delegate: observerDelegate
            )

            let navigationControllerDelegate = NavigationControllerDelegate()
            observer.navigationControllerDelegate = navigationControllerDelegate

            waitUntil(timeout: .seconds(1)) { done in
                // When
                navigationController.popViewController(animated: true)

                // We need to wait the end of the animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // Then
                    expect(navigationControllerDelegate.willShowViewControllers).toNot(beEmpty())
                    expect(navigationControllerDelegate.didShowViewControllers).toNot(beEmpty())
                    done()
                }
            }
        }

        it("should clean observer of view controllers not in the stack") {
            // Given
            let viewControllerToObserve = UIViewController()
            let viewControllerNotInTheStack = UIViewController()
            navigationController.pushViewController(viewControllerToObserve, animated: false)
            observer.observePopTransition(
                of: viewControllerToObserve,
                delegate: observerDelegate
            )
            // We observer viewControllerNotInTheStack even if not pushed in the navigation controller
            observer.observePopTransition(
                of: viewControllerNotInTheStack,
                delegate: observerDelegate
            )

            waitUntil(timeout: .seconds(1)) { done in
                // When
                navigationController.popViewController(animated: true)

                // We need to wait the end of the animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // Then

                    expect(navigationController.viewControllers.count).to(equal(1))
                    expect(observerDelegate.observedViewControllers).to(equal([viewControllerToObserve]))

                    // We now try to push/pop the viewControllerNotInTheStack
                    navigationController.pushViewController(viewControllerNotInTheStack, animated: false)
                    navigationController.popViewController(animated: true)

                    // We need to wait the end of the animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        // The viewControllerNotInTheStack should not be observed anymore
                        expect(navigationController.viewControllers.count).to(equal(1))
                        expect(observerDelegate.observedViewControllers).to(equal([viewControllerToObserve]))
                        done()
                    }
                }
            }
        }
    }
}
