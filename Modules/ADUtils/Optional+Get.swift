//
//  Optional+Get.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 26/03/2020.
//

import Foundation

public extension Optional {

    enum Error: Swift.Error {
        case isNil
    }

    /**
     * Returns the wrapped value as a throwing expression.
     */
    func get() throws -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            throw Error.isNil
        }
    }
}
