//
//  TargetSettings.swift
//  ADUtils
//
//  Created by Pierre Felgines on 22/09/16.
//
//

import Foundation

struct TargetSettings : Decodable {

    static var shared: TargetSettings = {
        let decoder = TargetSettingsDecoder()
        return decoder.decode()
    }()

    struct Colors: Decodable {
        var applidium_blue1: String = ""
        var applidium_blue2: String = ""
        var applidium_blue3: String = ""
        var applidium_blue4: String = ""
    }

    private var logLevel: Int = 0
    var hockeyAppId: String = ""
    var useWatchdog: Bool = false
    var useFileLogger: Bool = false
    var colors = Colors()

    //MARK: - Computed

    var ddLogLevel: DDLogLevel {
        let logLevels: [DDLogLevel] = [
            .off,
            .error,
            .warning,
            .info,
            .debug,
            .verbose,
            .all,
            ]
        guard logLevel >= 0 && logLevel < logLevels.count else {
            return .off
        }
        return logLevels[logLevel]
    }
}
