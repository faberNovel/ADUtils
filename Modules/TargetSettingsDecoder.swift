//
//  TargetSettingsDecoder.swift
//  ADUtilsApp
//
//  Created by Pierre Felgines on 01/09/2017.
//

import Foundation

class TargetSettingsDecoder {

    func decode() -> TargetSettings {
        guard let data = data() else {
            DDLogError("Target settings data is unvailable")
            return TargetSettings()
        }
        let decoder = PropertyListDecoder()
        do {
            return try decoder.decode(TargetSettings.self, from: data)
        } catch {
            DDLogError("Error decoding target settings \(error.localizedDescription)")
            return TargetSettings()
        }
    }

    //MARK: - Private

    private func data() -> Data? {
        guard let url = settingsUrl() else { return nil }
        return try? Data(contentsOf: url)
    }

    private func settingsUrl() -> URL? {
        return Bundle.main.url(forResource: "Info", withExtension: "plist")
    }
}
