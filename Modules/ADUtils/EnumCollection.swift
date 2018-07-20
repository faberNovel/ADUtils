//
//  EnumCollection.swift
//  Pods
//
//  Created by Benjamin Lavialle on 23/01/2017.
//
//

import Foundation

/**
 EnumCollection protocol is implementable by enums, and provides allValues var
 Implementation comes form :
 https://theswiftdev.com/2017/01/05/18-swift-gist-generic-allvalues-for-enums/
 It is not only for RawRepresentable enums, and is based on the fact that enum values are created contiguously

 Example :
 ```
 enum Alpha: String, EnumCollection {
     case a, b, c, d, e
 }

 Alpha.allValues
 ```
 */

public protocol EnumCollection: Hashable {
    static var allValues: [Self] { get }
}

public extension EnumCollection {

    public static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }

    public static var allValues: [Self] {
        return Array(self.cases())
    }

    public static var count: Int {
        return allValues.count
    }

    public static func get(at index: Int) -> Self {
        return allValues[index]
    }
}
