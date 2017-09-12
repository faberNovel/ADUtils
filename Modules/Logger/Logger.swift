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

    private lazy var fileLogger: DDFileLogger? = {
        let logger = DDFileLogger()
        logger?.rollingFrequency = TimeInterval(2 * 60 * 60) // 2 hours
        logger?.logFileManager.maximumNumberOfLogFiles = 1
        logger?.logFormatter = ADFileLoggerFormatter()
        return logger
    }()

    func setup() {
        let logLevel = TargetSettings.sharedSettings.logLevel
        if let xCodeConsoleLogger = DDTTYLogger.sharedInstance {
            xCodeConsoleLogger.colorsEnabled = true
            DDLog.add(xCodeConsoleLogger, with: logLevel)
        }
        if let appleSystemLogger = DDASLLogger.sharedInstance {
            DDLog.add(appleSystemLogger, with: logLevel)
        }
        if let fileLogger = fileLogger {
            DDLog.add(fileLogger, with: DDLogLevel.all)
        }
    }

    func fileLogs() -> Data {
        var data = Data()
        fileLogger?.logFileManager.sortedLogFileInfos.forEach {
            if let fileData = NSData(contentsOfFile: $0.filePath) {
                data.append(fileData as Data)
            }
        }
        return data
    }
}
