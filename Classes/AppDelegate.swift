//
//  AppDelegate.swift
//  ADUtils
//
//  Created by Edouard Siegel on 03/03/16.
//
//

import HockeySDK
import UIKit
import Watchdog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BITHockeyManagerDelegate {

    var window: UIWindow?
    var watchdog: Watchdog?
    var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setupLogger()
        setupHockeyApp()
        setupWatchdog()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white

        applicationCoordinator = ApplicationCoordinator(window: window!)
        applicationCoordinator?.start()

        window?.makeKeyAndVisible()
        return true
    }

    //MARK: - BITHockeyManagerDelegate

    func attachment(for crashManager: BITCrashManager!) -> BITHockeyAttachment! {
        return BITHockeyAttachment(
            filename: "report",
            hockeyAttachmentData: Logger.sharedInstance.fileLogs() as Data!,
            contentType: "text/plain"
        )
    }

    //MARK: - Private

    private func setupLogger() {
        Logger.sharedInstance.setup(
            logLevel: TargetSettings.shared.ddLogLevel,
            useFileLogger: TargetSettings.shared.useFileLogger
        )
    }

    private func setupHockeyApp() {
        guard !TargetSettings.shared.hockeyAppId.isEmpty else {
            return
        }
        BITHockeyManager.shared().configure(withIdentifier: TargetSettings.shared.hockeyAppId)
        BITHockeyManager.shared().crashManager.crashManagerStatus = .autoSend
        BITHockeyManager.shared().crashManager.isAppNotTerminatingCleanlyDetectionEnabled = true
        if TargetSettings.shared.useFileLogger {
            BITHockeyManager.shared().delegate = self
        }
        BITHockeyManager.shared().start()
    }

    private func setupWatchdog() {
        guard TargetSettings.shared.useWatchdog else {
            return;
        }
        watchdog = Watchdog(threshold: 0.2) {
            DDLogWarn("[Watchdog] Block main thread for 0.2s");
        }
    }
}
