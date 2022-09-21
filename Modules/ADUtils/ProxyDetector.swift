//
//  ProxyDetector.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 03/10/2017.
//

import Foundation
import UIKit

/// ProxyDetector check on proxy use and display notification if in use
public class ProxyDetector: Sendable {

    private let windowProvider: @MainActor () -> UIWindow?

    /**
    Check on proxy use and display an alert view if activated
    - parameter windowProvider defines the way proxy detector is receiving a window to display a possible alert
    */
    public init(windowProvider: @MainActor @escaping () -> UIWindow?) {
        self.windowProvider = windowProvider
    }

    /**
     Check on proxy use and display an alert view if activated
     - parameter time interval before check, it may be usefull if you want to check on proxy at application start,
     but after launchscreen presentation
     - note: Does not check on proxy on simulator
     - note: The alert view is presented on the application top most view controller
     - note: The alert view is dismissed on its own after one second
     */
    @MainActor
    public func handleProxyNotification(after delay: TimeInterval) async {
        guard TARGET_OS_SIMULATOR == 0 else {
            // (Benjamin Lavialle) 2018-01-18 Do not notify proxy on simulator
            return
        }
        try? await Task.sleep(nanoseconds: NSEC_PER_SEC * UInt64(delay))
        guard let topMostViewController = self.topMostViewController else { return }
        self.notifyIfProxyActivated(in: topMostViewController)
    }

    /**
     Check on proxy use and display an alert view if activated
     - parameter viewController: the view controller presenting the alert view
     - note: The alert view is dismissed on its own after one second
     */
    public func notifyIfProxyActivated(in viewController: UIViewController) {
        let name = proxyName
        guard name != nil else { return }
        let alertController = UIAlertController(
            title: "Proxy",
            message: "HTTP PRoxy is activated (\(name ?? "unknown"))",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true) { [weak alertController] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                alertController?.dismiss(animated: true, completion: nil)
            })
        }
    }

    // MARK: - Private

    private var proxyName: String? {
        let cfNetworkProxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue()
        let networkProxySettings = cfNetworkProxySettings as? [String: AnyObject]
        let httpProxy = networkProxySettings?["HTTPProxy"] as? String
        let httpsProxy = networkProxySettings?["HTTPSProxy"] as? String
        return httpProxy ?? httpsProxy
    }

    @MainActor
    private var topMostViewController: UIViewController? {
        var viewController = windowProvider()?.rootViewController
        while let presentedViewController = viewController?.presentedViewController {
            viewController = presentedViewController
        }
        return viewController
    }
}
