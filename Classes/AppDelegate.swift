//
//  AppDelegate.swift
//  ADUtils
//
//  Created by Edouard Siegel on 03/03/16.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white

        window?.rootViewController = ViewController()

        window?.makeKeyAndVisible()
    }
}
