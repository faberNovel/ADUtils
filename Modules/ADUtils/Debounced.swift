//
//  Debounced.swift
//  ADUtils
//
//  Created by Jonathan Seguin on 12/02/2020.
//

import Foundation

/**
 * A class that can be used to facilitate the use of debounced action.
 * Use it when you need an action to be automatically debounced at each call.
 * You can use it as a propertyWrapper, or in a more classical way by using the `debounce` function.
 */
@propertyWrapper
public class Debounced {

    /// The queue in which you want your action to run
    private let queue: DispatchQueue

    /// The delay of the debounced action
    private let delay: TimeInterval

    private var workItem = DispatchWorkItem(block: {})
    private var action: () -> Void = {}

    /**
     * Init used for the property wrapper
     */
    public init(wrappedValue: @escaping () -> Void,
                delay: TimeInterval,
                queue: DispatchQueue = .main) {
        self.delay = delay
        self.queue = queue
        self.wrappedValue = wrappedValue
    }

    /**
    * Init used for a classical usage (without property wrapper)
    */
    public init(delay: TimeInterval,
                queue: DispatchQueue = .main) {
        self.delay = delay
        self.queue = queue
    }

    // MARK: - Property Wrapper

    public var wrappedValue: () -> Void {
        get {
            return action
        }
        set {
            /// Each time the action parameter is called, the workItem is reset
            /// so the action is really executed after `delay`
            self.action = {
                self.debounceAction(newValue)
            }
        }
    }

    // MARK: - Public

    /**
     * Use this function if you prefer to use a more classical method than property wrapper
     * - parameter action: the action to debounce
     */
    public func debounce(_ action: @escaping () -> Void) {
        debounceAction(action)
    }

    // MARK: - Private

    private func debounceAction(_ action: @escaping () -> Void) {
        workItem.cancel()
        workItem = DispatchWorkItem(block: action)
        queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
    }
}

/**
 * Typealias to create instances of the Debounced class, without using the property wrapper
 */
public typealias Debouncer = Debounced
