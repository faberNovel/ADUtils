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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        setupLogger()
        setupHockeyApp()
        setupWatchdog()

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()

        applicationCoordinator = ApplicationCoordinator(window: window!)
        applicationCoordinator?.start()

        window?.makeKeyAndVisible()
        return true
    }

    //MARK: - BITHockeyManagerDelegate

    func attachmentForCrashManager(crashManager: BITCrashManager!) -> BITHockeyAttachment! {
        return BITHockeyAttachment(
            filename: "report",
            hockeyAttachmentData: Logger.sharedInstance.fileLogs(),
            contentType: "text/plain"
        )
    }

    //MARK: - Private

    private func setupLogger() {
        guard TargetSettings.sharedSettings.useFileLogger else {
            return
        }
        Logger.sharedInstance.setup()
    }

    private func setupHockeyApp() {
        guard !TargetSettings.sharedSettings.hockeyAppId.isEmpty else {
            return
        }
        BITHockeyManager.sharedHockeyManager().configureWithIdentifier(TargetSettings.sharedSettings.hockeyAppId)
        BITHockeyManager.sharedHockeyManager().crashManager.crashManagerStatus = .AutoSend
        BITHockeyManager.sharedHockeyManager().crashManager.enableAppNotTerminatingCleanlyDetection = true
        if TargetSettings.sharedSettings.useFileLogger {
            BITHockeyManager.sharedHockeyManager().delegate = self
        }
        BITHockeyManager.sharedHockeyManager().startManager()
    }

    private func setupWatchdog() {
        guard TargetSettings.sharedSettings.useWatchdog else {
            return;
        }
        watchdog = Watchdog(threshold: 0.2, handler: { (duration) -> () in
            DDLogWarn("[Watchdog] Block main thread for \(duration)s");
        })
    }
}
