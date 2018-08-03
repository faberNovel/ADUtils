//
//  PropertyListArchiver.swift
//  Pods
//
//  Created by Pierre Felgines on 05/01/17.
//
//

import Foundation

//http://redqueencoder.com/property-lists-and-user-defaults-in-swift/

@available(*, deprecated, message: "Use `Codable` instead")
public protocol PropertyListReadable {
    func propertyListRepresentation() -> NSDictionary
    init?(propertyListRepresentation: NSDictionary?)
}

/**
 This class allows Swift struct to be stored in UserDefaults.
 */
public class PropertyListArchiver {

    private let defaults: UserDefaults
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()

    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    /**
     Set a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func set(_ value: URL?, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    /**
     Set a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func set(_ value: Bool, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    /**
     Set a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func set(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    /**
     Set a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func set(_ value: Float, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    /**
     Set a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func set(_ value: Double, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    /**
     Set a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func set(_ value: Int, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    /**
     Set a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func set<C : Codable>(_ value: C, forKey key: String) throws {
        let data = try encoder.encode(value)
        defaults.set(data, forKey: key)
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key if it exists or nil
     */
    public func value<C : Codable>(forKey key: String) throws -> C? {
        return try defaults.data(forKey: key).flatMap { try decoder.decode(C.self, from: $0) }
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key
     */
    public func value(forKey key: String) -> Bool {
        return defaults.bool(forKey: key)
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key
     */
    public func value(forKey key: String) -> String? {
        return defaults.string(forKey: key)
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key
     */
    public func value(forKey key: String) -> Int {
        return defaults.integer(forKey: key)
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key
     */
    public func value(forKey key: String) -> Float {
        return defaults.float(forKey: key)
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key
     */
    public func value(forKey key: String) -> Double {
        return defaults.double(forKey: key)
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key
     */
    public func value(forKey key: String) -> URL? {
        return defaults.url(forKey: key)
    }

    /**
     Read the values for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The array associated to the key if it exists or an empty array
     */
    public func array<C : Codable>(forKey key: String) throws -> [C] {
        return try value(forKey: key) ?? []
    }

    /**
     Save a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    @available(*, deprecated, message: "Use `set(_:,forKey:)` instead")
    public func save<T: PropertyListReadable>(value: T, forKey key: String) {
        defaults.set(value.propertyListRepresentation(), forKey: key)
        defaults.synchronize()
    }

    /**
     Save values for a specific key in the user defaults.
     - parameter values: The array to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    @available(*, deprecated, message: "Use `set(_:forKey:)` instead")
    public func save<T: PropertyListReadable>(values: [T], forKey key: String) {
        let encodedValues = values.map { $0.propertyListRepresentation() }
        defaults.set(encodedValues, forKey: key)
        defaults.synchronize()
    }

    /**
     Read the value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The value associated to the key if it exists or nil
     */
    @available(*, deprecated, message: "Use `value(forKey:)` instead")
    public func readValue<T: PropertyListReadable>(forKey key: String) -> T? {
        let savedValue = defaults.value(forKey: key)
        if let dictionary = savedValue as? NSDictionary {
            return T(propertyListRepresentation: dictionary)
        }
        return nil
    }

    /**
     Read the values for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     - returns: The values associated to the key if it exists or empty array
     */
    @available(*, deprecated, message: "Use `value(forKey:)` instead")
    public func readValues<T: PropertyListReadable>(forKey key: String) -> [T] {
        let savedValue = defaults.value(forKey: key)
        if let array = savedValue as? [AnyObject] {
            return array
                .map { $0 as? NSDictionary }
                .flatMap { T(propertyListRepresentation: $0) }
        }
        return []
    }

    /**
     Delete a value for a specific key in the user defaults.
     - parameter key: The key to read in the user defaults.
     */
    public func deleteValue(forKey key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
