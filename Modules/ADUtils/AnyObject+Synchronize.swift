//
//  AnyObject+Synchronize.swift
//  BabolatPulse
//
//  Created by Benjamin Lavialle on 07/09/16.
//
//

import Foundation

/**
 Execute the given block using the lock as lock for mutex

 - parameter lock: The lock used for mutex

 - parameter block: The block to synchronize

 - returns: The value returned by the block
 */
public func synchronize<T>(_ lock: Any, block: () -> T) -> T {
    let returnValue: T
    objc_sync_enter(lock)
    returnValue = block()
    objc_sync_exit(lock)
    return returnValue
}
