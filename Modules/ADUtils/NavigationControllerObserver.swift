//
//  NavigationControllerObserver.swift
//  Pods
//
//  Created by Pierre Felgines on 21/06/2017.
//
//

import Foundation
import UIKit

/**
 Protocol NavigationControllerObserverDelegate provides methods to observe `NavigationControllerObserver` actions
 */
public protocol NavigationControllerObserverDelegate : class {
    /**
     Callback when a `viewController` is popped from the `navigationController` stack
     - parameter observer: the observer that observed the pop transition
     - parameter viewController: the `UIViewController` that has been popped from the stack
     */
    func navigationControllerObserver(_ observer: NavigationControllerObserver,
                                      didObservePopTransitionFor viewController: UIViewController)
}

// We can't use Weak<T: AnyObject> here because we would have
// to declare NavigationControllerObserverDelegate as @objc
private class NavigationControllerObserverDelegateContainer {

    private(set) weak var value: NavigationControllerObserverDelegate?

    init(value: NavigationControllerObserverDelegate) {
        self.value = value
    }
}

/**
 The `NavigationControllerObserver` class provides a simple API to observe the
 pop transitions that occur in a `navigationController` stack.

 One drawback of `UINavigationController` is that its delegate is shared among multiple
 view controllers and this requires a lot of bookkeeping to register multiple delegates.

 `NavigationControllerObserver` allows to register a delegate per viewController we want to observe.
 What's more the class provides a `navigationControllerDelegate` property used to forward all the
 `UINavigationControllerDelegate` methods to another navigationController delegate if need be.

 - important: The `NavigationControllerObserver` will observe only *animated* pop transitions.
 Indeed, if you call `popViewController(animated: false)` you won't be notified.
 */
public class NavigationControllerObserver : NSObject, UINavigationControllerDelegate {

    /**
     All calls from `UINavigationControllerDelegate` methods are forwarded to this object
     */
    public weak var navigationControllerDelegate: UINavigationControllerDelegate? {
        didSet {
            // Make the navigationController reevaluate respondsToSelector
            // for UINavigationControllerDelegate methods
            navigationController?.delegate = nil
            navigationController?.delegate = self
        }
    }

    // Do not retain view controllers, but retain delegate containers as they are containers to weak objects, or they
    // will be deallocated right the way
    private let viewControllersToDelegates = NSMapTable<UIViewController, NavigationControllerObserverDelegateContainer>
        .weakToStrongObjects()
    private weak var navigationController: UINavigationController?

    /**
     - parameter navigationController: the `UINavigationController` we want to observe
     */
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }

    //MARK: - NSObject

    override public func responds(to aSelector: Selector!) -> Bool {
        if shouldForwardSelector(aSelector) {
            return navigationControllerDelegate?.responds(to: aSelector) ?? false
        }
        return super.responds(to: aSelector)
    }

    override public func forwardingTarget(for aSelector: Selector!) -> Any? {
        if shouldForwardSelector(aSelector) {
            return navigationControllerDelegate
        }
        return super.forwardingTarget(for: aSelector)
    }

    //MARK: - Public

    /**
     Observe a pop transition in the `navigationController` stack
     - parameter viewController: the `UIViewController` instance to observe in the `navigationController` stack
     - parameter delegate: The delegate that will be notified of the transition
     */
    public func observePopTransition(of viewController: UIViewController,
                                     delegate: NavigationControllerObserverDelegate) {
        let wrappedDelegate = NavigationControllerObserverDelegateContainer(value: delegate)
        viewControllersToDelegates.setObject(wrappedDelegate, forKey: viewController)
    }

    /**
     Stop observing the viewController and remove the associated delegate
     - parameter viewController: The viewController being observed
     */
    public func removeDelegate(observing viewController: UIViewController) {
        viewControllersToDelegates.removeObject(forKey: viewController)
    }

    /**
     Stop observing the viewController associated to the delegate object and remove the delegate.
     - parameter delegate: The delegate previously registered
     */
    public func remove(_ delegate: NavigationControllerObserverDelegate) {
        let viewControllersToRemove = viewControllersToDelegates
            .keyEnumerator()
            .allObjects
            .compactMap { $0 as? UIViewController }
            .filter { viewControllersToDelegates.object(forKey: $0)?.value === delegate }
        viewControllersToRemove.forEach { removeDelegate(observing: $0) }
    }

    /**
     Stop observing all the viewController and remove all delegates
     */
    public func removeAllDelegates() {
        viewControllersToDelegates.removeAllObjects()
    }

    //MARK: - UINavigationControllerDelegate

    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        navigationControllerDelegate?.navigationController?(
            navigationController,
            didShow: viewController,
            animated: animated
        )

        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }

        // Clean up state before calling delegate method
        let delegateToCall = viewControllersToDelegates.object(forKey: fromViewController)?.value
        removeDelegate(observing: fromViewController)
        cleanOutdatedViewControllers()
        delegateToCall?.navigationControllerObserver(self, didObservePopTransitionFor: fromViewController)
    }

    //MARK: - Private

    private func shouldForwardSelector(_ aSelector: Selector!) -> Bool {
        let description = protocol_getMethodDescription(UINavigationControllerDelegate.self, aSelector, false, true)
        return
            description.name != nil // belongs to UINavigationControllerDelegate
                && class_getInstanceMethod(type(of: self), aSelector) == nil // self does not implement aSelector
    }

    private func cleanOutdatedViewControllers() {
        let viewControllersToRemove = viewControllersToDelegates
            .keyEnumerator()
            .allObjects
            .compactMap { $0 as? UIViewController }
            .filter { $0.parent != self.navigationController }
        viewControllersToRemove.forEach { removeDelegate(observing: $0) }
    }
}
