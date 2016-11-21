//
//  ApplicationCoordinator.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/09/16.
//
//

import Foundation

class ApplicationCoordinator : Coordinator {

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    //MARK: - Coordinator

    override func start() {
        window.rootViewController = SharedViewController()
    }
}
