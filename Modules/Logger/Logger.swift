//
//  Logger.swift
//  ADUtils
//
//  Created by Pierre Felgines on 13/06/16.
//
//

import Foundation
import CocoaLumberjack

class Logger {

    static let sharedInstance = Logger()

    private lazy var fileLogger: DDFileLogger = {
        let logger = DDFileLogger()
        logger.rollingFrequency = 2 * 60 * 60 // 2 hours
        logger.logFileManager.maximumNumberOfLogFiles = 1
        logger.logFormatter = ADFileLoggerFormatter()
        return logger
    }()

    func setup() {
        let logLevel = TargetSettings.sharedSettings.logLevel

        let xCodeConsoleLogger = DDTTYLogger.sharedInstance()
        xCodeConsoleLogger.colorsEnabled = true

        let appleSystemLogger = DDASLLogger.sharedInstance()

        DDLog.addLogger(xCodeConsoleLogger, withLevel: logLevel)
        DDLog.addLogger(appleSystemLogger, withLevel: logLevel)
        DDLog.addLogger(fileLogger, withLevel: DDLogLevel.All)
    }

    func fileLogs() -> NSData {
        let data = NSMutableData()
        fileLogger.logFileManager.sortedLogFileInfos().forEach {
            if let fileData = NSData(contentsOfFile: $0.filePath) {
                data.appendData(fileData)
            }
        }
        return data.copy() as! NSData
    }
}
