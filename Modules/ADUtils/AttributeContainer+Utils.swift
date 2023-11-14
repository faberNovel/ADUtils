//
//  AttributeContainer+Utils.swift
//  ADUtils
//
//  Created by Alexandre Podlewski on 14/11/2023.
//

import Foundation

@available(iOS 15, tvOS 15, *)
extension AttributeContainer {
    /**
     Create an `AttributeContainer` using a configuration closure
     */
    public init(_ configurationBlock: (inout Self) -> Void) {
        self.init()
        configurationBlock(&self)
    }
}
