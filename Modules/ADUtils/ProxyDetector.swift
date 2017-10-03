//
//  ProxyDetector.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 03/10/2017.
//

import Foundation
import UIKit

public class ProxyDetector {

    public init() {}

    public var isProxyActivated: Bool {
        return proxyName != nil
    }

    public func handleProxyNotification(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            //???: (Benjamin Lavialle) 2017-10-03 Do not weak self, we need to keep self to complete action
            guard let topMostViewController = self.topMostViewController else { return }
            self.notifyIfProxyActivated(in: topMostViewController)
        })
    }

    public func notifyIfProxyActivated(in viewController: UIViewController) {
        guard isProxyActivated else { return }
        let alertController = UIAlertController(
            title: "Proxy",
            message: "HTTP PRoxy is activated (\(proxyName ?? "unknown"))",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true) { [weak alertController] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                alertController?.dismiss(animated: true, completion: nil)
            })
        }
    }

    //MARK: - Private

    private var proxyName: String? {
        let cfNetworkProxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue()
        let networkProxySettings =  cfNetworkProxySettings as? [String: AnyObject]
        let httpProxy = networkProxySettings?["HTTPProxy"] as? String
        let httpsProxy = networkProxySettings?["HTTPSProxy"] as? String
        return httpProxy ?? httpsProxy
    }

    private var topMostViewController: UIViewController? {
        var viewController = UIApplication.shared.delegate?.window??.rootViewController
        while let presentedViewController = viewController?.presentedViewController {
            viewController = presentedViewController
        }
        return viewController
    }
}
