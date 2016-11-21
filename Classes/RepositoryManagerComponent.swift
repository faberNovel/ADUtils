//
//  RepositoryManagerComponent.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/09/16.
//
//

import Foundation
import Cleanse

class RepositoryManagerComponent : Component {
    typealias Root = RepositoryManager

    func configure<B : Binder>(binder binder: B) {
        binder
            .bind(RepositoryManager)
            .to(factory: RepositoryManager.init)
    }
}
