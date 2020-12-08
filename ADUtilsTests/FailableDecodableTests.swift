//
//  FailableDecodableTests.swift
//  ADUtilsTests
//
//  Created by Roland Borgese on 25/04/2019.
//

import ADUtils
import Quick
import Nimble

private struct File: Codable {
    let name: String
    let size: Int
    let ext: String
}

private struct LossyFolder: Codable {
    let name: String
    let files: [File]

    // MARK: - Codable

    private enum CodingKeys: CodingKey {
        case name
        case files
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        files = try container.ad_safelyDecodeArray(of: File.self, forKey: .files)
    }
}

extension LossyFolder {
    init(name: String, files: [File]) {
        self.name = name
        self.files = files
    }
}

private struct StrictFolder: Codable {
    let name: String
    let files: [File]
}

class KeyedDecodingContainerTests: QuickSpec {

    override func spec() {
        // Slack, Candidates and My-CV are valids, other are invalids
        let desktopJSON = """
            {
                "name": "Desktop",
                "files":
                    [
                        {
                            "name": "Slack",
                            "size": 236,
                            "ext": "app",
                            "picture": "slack.png"
                        },
                        {
                            "name": "Candidates",
                            "size": 67,
                            "ext": ".xls"
                        },
                        {
                            "name": "RawData",
                            "size": 543
                        },
                        {
                            "name": "My-CV",
                            "size": 78,
                            "ext": ".txt"
                        },
                        {
                            "name": "SizeError",
                            "size": null,
                            "ext": ".ghost"
                        }

                    ]

            }
            """
        let desktopData = desktopJSON.data(using: .utf8)!

        it("should decode the JSON of a struct which contains arrays with some invalid data using custom Decoder") {
            let decoder = JSONDecoder()
            let nullableDesktop = try? decoder.decode(LossyFolder.self, from: desktopData)
            expect(nullableDesktop).toNot(beNil())
            let desktop = nullableDesktop!
            expect(desktop.files.count).to(equal(3))
        }

        it("should throw error when decoding the JSON of a struct with some invalid data using standard method") {
            let decoder = JSONDecoder()
            expect {
                let decoded = try decoder.decode(StrictFolder.self, from: desktopData)
                return expect(decoded).to(beNil())
            }
            .to(throwError())
        }

        // Slack and My-CV are valids, other are invalids
        let filesJSON = """
            [
                {
                    "name": "Slack",
                    "size": 236,
                    "ext": "app",
                    "picture": "slack.png"
                },
                {
                    "name": "RawData",
                    "size": 543
                },
                {
                    "name": "My-CV",
                    "size": 78,
                    "ext": ".txt"
                },
                {
                    "name": "SizeError",
                    "size": null,
                    "ext": ".ghost"
                }

            ]
            """
        let filesData = filesJSON.data(using: .utf8)!

        it("JSONDecoder.ad_safelyDecodeArray should decode array with some invalid data") {
            let decoder = JSONDecoder()
            let nullableFiles = try? decoder.ad_safelyDecodeArray(of: File.self, from: filesData)
            expect(nullableFiles).toNot(beNil())
            let files = nullableFiles!
            expect(files.count).to(equal(2))
        }

        it("should throw error when decoding array with some invalid data using standard method") {
            let decoder = JSONDecoder()
            expect {
                let decoded = try decoder.decode([File].self, from: filesData)
                return expect(decoded).to(beNil())
            }
            .to(throwError())
        }

        it("should not affect encoding") {
            let desktop = LossyFolder(
                name: "",
                files: [File(name: "A", size: 78, ext: ".toto"), File(name: "B", size: 98, ext: ".dede")]
            )

            let encoder = JSONEncoder()
            let nullableEncoded = try? encoder.encode(desktop)
            expect(nullableEncoded).toNot(beNil())
            let encoded = nullableEncoded!

            let decoder = JSONDecoder()
            let nullableDecoded = try? decoder.decode(LossyFolder.self, from: encoded)
            expect(nullableDecoded).toNot(beNil())
            let decoded = nullableDecoded!
            expect(decoded.files.count).to(equal(desktop.files.count))
        }
    }

}
