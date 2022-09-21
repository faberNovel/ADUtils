//
//  Sendable+Async.swift
//  ADUtils
//
//  Created by Yassine Ghazouan on 21/09/2022.
//

import Foundation

public extension Sendable {
    @discardableResult
    public func async(completion: @Sendable @escaping (Self) async -> Void) -> Task<Void, Never> {
        Task { await completion(self) }
    }
}
