//
//  MainActor+enqueue.swift
//  ADUtils
//
//  Created by Yassine Ghazouan on 21/09/2022.
//

import Foundation

public extension MainActor {

    private typealias ResultType = @MainActor @Sendable () async -> Void

    private static var continuation: AsyncStream<ResultType>.Continuation? = {
        var continuation: AsyncStream<ResultType>.Continuation?
        let stream = AsyncStream<ResultType> { continuation = $0 }
        subscribe(to: stream)
        return continuation
    }()

    private static func subscribe(to stream: AsyncStream<ResultType>) {
        Task {
            for await action in stream {
                await withCheckedContinuation { continuation in
                    Task { @MainActor in
                        continuation.resume()
                        await action()
                    }
                }
            }
        }
    }

    /// Creates a Task that's running the completion on main thread
    /// and ensures any previous Task created with enqueue operation has started before running the current task, this has an equivalent behavior to DispatchQueue.main.async with access to asynchronous context
    ///
    /// - Parameters:
    ///   - action: An async closure to be executed on the main thread when it's free.
    /// The completion is garenteed to be executed at some point
    /// and it's freed from memory right after, therefore, no retain cycle is possible
    static func enqueue(with action: @MainActor @Sendable @escaping () async -> Void) {
        continuation?.yield(action)
    }
}
