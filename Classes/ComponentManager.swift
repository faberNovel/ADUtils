//
//  ComponentManager.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/09/16.
//
//

import Foundation
import Cleanse

class ComponentManager {

    static let sharedInstance = ComponentManager()

    private var repositoryManager: RepositoryManager
    private var applicationModule: ApplicationModule

    private init() {
        let repositoryManagerComponent = RepositoryManagerComponent()
        repositoryManager = try! repositoryManagerComponent.build()
        applicationModule = ApplicationModule(repositoryManager: repositoryManager)
    }
}
