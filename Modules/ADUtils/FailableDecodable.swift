//
//  FailableDecodable.swift
//  ADUtils
//
//  Created by Roland Borgese on 25/04/2019.
//

import Foundation

/**
 Implementation of https://bugs.swift.org/browse/SR-5953
 Inspired by https://stackoverflow.com/a/46369152/4269317
 */

/**
 Wrapper around Decodable which does not throw if decoding fails
 */
struct FailableDecodable<Base: Decodable>: Decodable {
    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

/**
 Convenience struct to store several FailableDecodables
 */
struct FailableDecodableArray<Element: Decodable>: Decodable {
    let elements: [Element]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let elements = try container.decode([FailableDecodable<Element>].self)
        self.elements = elements.compactMap { $0.base }
    }
}

extension KeyedDecodingContainer {
    /// Decodes an array of values of the given type for the given key.
    /// If the decoding of a value fails, it is ignored and will not be present in the final array.
    ///
    /// - parameter type: The type of value in the array to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: An array of value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    public func ad_safelyDecodeArray<T: Decodable>(of type: T.Type,
                                                   forKey key: KeyedDecodingContainer.Key) throws -> [T] {
        return try decode(FailableDecodableArray<T>.self, forKey: key).elements
    }
}

extension JSONDecoder {
    /// Decodes a top-level array of values of the given type from the given JSON representation.
    /// If the decoding of a value fails, it is ignored and will not be present in the final array.
    ///
    /// - parameter type: The type of value in the array to decode.
    /// - parameter data: The data to decode from.
    /// - returns: An array of values of the requested type.
    public func ad_safelyDecodeArray<T: Decodable>(of type: T.Type, from data: Data) throws -> [T] {
        return try decode(FailableDecodableArray<T>.self, from: data).elements
    }
}

extension PropertyListDecoder {
    /// Decodes a top-level array of values of the given type from the given property list representation.
    /// If the decoding of a value fails, it is ignored and will not be present in the final array.
    ///
    /// - parameter type: The type of value in the array to decode.
    /// - parameter data: The data to decode from.
    /// - returns: An array of values of the requested type.
    public func ad_safelyDecodeArray<T: Decodable>(of type: T.Type, from data: Data) throws -> [T] {
        return try decode(FailableDecodableArray<T>.self, from: data).elements
    }
}
