//
//  Coordinator.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/09/16.
//
//

import Foundation

// Base class for all coordinators.
// Each coordinator keeps an array of children coordinators (to avoid children being deallocated)

class Coordinator {
    var children: [Coordinator] = []
    func start() { fatalError("Should be overriden") }
}

extension Coordinator: Equatable {}
func ==(lhs: Coordinator, rhs: Coordinator) -> Bool {
    return lhs === rhs
}

// This extension add handy methods to manipulate children array

extension Coordinator {

    func addChild(coordinator: Coordinator) {
        children.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        if let index = children.indexOf(coordinator) {
            children.removeAtIndex(index)
        }
    }

    func removeAllChildren() {
        children.removeAll(keepCapacity: false)
    }
}
