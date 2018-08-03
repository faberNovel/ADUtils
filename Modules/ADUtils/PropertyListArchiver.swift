//
//  PropertyListArchiver.swift
//  Pods
//
//  Created by Pierre Felgines on 05/01/17.
//
//

import Foundation

//http://redqueencoder.com/property-lists-and-user-defaults-in-swift/

public protocol PropertyListReadable {
    func propertyListRepresentation() -> NSDictionary
    init?(propertyListRepresentation: NSDictionary?)
}

/**
 This class allows Swift struct to be stored in UserDefaults.
 */
public class PropertyListArchiver {

    private let defaults: UserDefaults

    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    /**
     Save a value for a specific key in the user defaults.
     - parameter value: The object to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
    public func save<T: PropertyListReadable>(value: T, forKey key: String) {
        defaults.set(value.propertyListRepresentation(), forKey: key)
        defaults.synchronize()
    }

    /**
     Save values for a specific key in the user defaults.
     - parameter values: The array to store in the user defaults.
     - parameter key: The key to use in the user defaults.
     */
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
