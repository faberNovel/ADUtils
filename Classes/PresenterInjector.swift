//
//  PresenterInjector.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/09/16.
//
//

import Foundation
import Cleanse

// A protocol to handle the presenter injection in ViewControllers :
// 1- ViewControllers implement PresenterInjectable, i.e they have a presenter property
// 2- the ViewController components install a PresenterInjector<ViewController> module
// 3- Coordinators call viewController.injectProperties(ViewControllerComponent(...)) to build the viewController dependency graph.
// (If you need a ViewController having 2 presenters, forget about PresenterInjectable ; you can either write
// your custom PresenterInjector, or use constructor injection on Presenters and bind them manually to viewControllers)

protocol PresenterInjectable: class {
    associatedtype P // presenter class

    var presenter: P? { get set }

    func inject(presenter: P) -> Void

    func injectProperties<C : Cleanse.Component where C.Root == PropertyInjector<Self>>(component: C)
}

extension PresenterInjectable {

    func inject(presenter: P) -> Void {
        self.presenter = presenter
    }

    func injectProperties<C : Cleanse.Component where C.Root == PropertyInjector<Self>>(component: C) {
        let propertyInjector = try! component.build()
        propertyInjector.injectProperties(into: self)
    }
}

class PresenterInjector<TargetType: PresenterInjectable>: Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {
        binder
            .bindPropertyInjectionOf(TargetType.self)
            .to(injector: TargetType.inject)
    }
}
