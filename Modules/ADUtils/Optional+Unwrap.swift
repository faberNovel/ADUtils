//
//  Optionnal+Unwrap.swift
//  Pods
//
//  Created by Benjamin Lavialle on 05/05/2017.
//
//

import Foundation
import UIKit

public extension Optional {

    /**
     Execute the block if unwrapping the optional is possible
     It shortens the use of optional inside small closures in which ones the optional is required:

     myMethodWithCompletion() { [weak self] (args) in
       self.unwrap { $0.delegate.useSelf($0, with: args) }
     }

     The block returns intentionnally Void to avoid using the unwrap to execute a block and map the value which could be messy,
     this may change to a generic function if we find interesting use cases

     - parameter block: The possibly executed block
     */

    func unwrap(execute block: ((Wrapped) -> Void)) {
        switch self {
        case .none:
            break
        case let .some(wrapped):
            block(wrapped)
        }
    }
}
