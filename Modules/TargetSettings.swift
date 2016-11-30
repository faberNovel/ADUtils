//
//  TargetSettings.swift
//  ADUtils
//
//  Created by Pierre Felgines on 22/09/16.
//
//

import Foundation

class TargetSettings : NSObject {

    // Config
    private(set) var logLevel: DDLogLevel = .all
    private(set) var hockeyAppId: String = ""
    private(set) var useWatchdog: Bool = false
    private(set) var useFileLogger: Bool = false
    // Colors
    private(set) var applidium_blue1: String = ""
    private(set) var applidium_blue2: String = ""
    private(set) var applidium_blue3: String = ""
    private(set) var applidium_blue4: String = ""


    static let sharedSettings = TargetSettings()

    //MARK: - NSObject

    override init() {
        super.init()
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else {
                fatalError("Cannot find Info.plist")
        }
        extract(from: dictionary)
    }

    //MARK: - Private

    private func extract(from dictionary: [String: AnyObject]) {
        for (key, value) in dictionary {

            if key == "logLevel", let value = value as? Int {
                setLogLevelFromPlist(value)
                continue
            }

            let capitalizedKey = key.firstLetterCapitalized()
            let valueIsString = value is String
            if responds(to: NSSelectorFromString("set\(capitalizedKey):")) &&
                (!valueIsString || (valueIsString && !(value as! String).isEmpty)) {
                setValue(value, forKey: key)
            } else if let subDictionary = dictionary[key] as? [String: AnyObject] {
                extract(from: subDictionary)
            }
        }
    }

    private func setLogLevelFromPlist(_ logLevel: Int) {
        let logLevels: [DDLogLevel] = [.off, .error, .warning, .info, .debug, .verbose, .all]
        guard logLevel >= 0 && logLevel < logLevels.count else {
            return
        }
        self.logLevel = logLevels[logLevel]
    }
}

private extension String {
    func firstLetterCapitalized() -> String {
        guard !isEmpty else { return "" }
        let index = characters.index(startIndex, offsetBy: 1)
        return substring(to: index).capitalized + substring(from: index)
    }
}
