//
//  AttributedStringTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import UIKit
import SwiftUI
import Nimble
import SnapshotTesting
import Quick
@testable import ADUtils
@testable import ADUtilsApp

@MainActor
class AttributedStringTest: QuickSpec {

    override class func spec() {

        let stringTest = { (string: String, arguments: [String], imageName: String) -> Void in
            guard
                let smallFont = UIFont(name: "HelveticaNeue", size: 12.0),
                let bigFont = UIFont(name: "HelveticaNeue", size: 24.0) else {
                    fail("Font HelveticaNeue do not exists")
                    return
            }
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.red,
                .font: smallFont
            ]
            let attributes1: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.green,
                .font: smallFont
            ]
            let attributes2: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.blue,
                .font: bigFont
            ]

            let differentFormatAttributes = arguments.enumerated().map({ (arg) -> [NSAttributedString.Key: Any] in
                let (index, _) = arg
                return [attributes1, attributes2][index % 2]
            })

            let attributedString = string.attributedString(
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: differentFormatAttributes
            )
            let label = UILabel()
            label.attributedText = attributedString
            label.sizeToFit()
            assertSnapshot(matching: label, as: .image, named: imageName)
        }

        it("NSAttributedString snapshots should match") {
            let format = "Test %1$@ %2$@"
            let value1 = "Toto"
            let value2 = "Testi testo"
            stringTest(format, [value1, value2], "DifferentAttributes")
            stringTest(format, [value1, value1], "SameAttributes")
            let invertedFormat = "Test %2$@ %1$@"
            stringTest(invertedFormat, [value1, value2], "InvertedFormat")
            let singleFormat = "Test %@"
            stringTest(singleFormat, [value1], "SingleFormat")
            let formatWithEmoji = "Test 🦁 %1$@ %2$@"
            stringTest(formatWithEmoji, [value1, value2], "EmojiInFormat")
        }

        if #available(iOS 15.0, *) {
            testAttributedString()
        }
    }

    @available(iOS 15.0, tvOS 15.0, *)
    class func testAttributedString() {

        guard
            let smallFont = UIFont(name: "HelveticaNeue", size: 12.0),
            let bigFont = UIFont(name: "HelveticaNeue", size: 24.0) else {
            fail("Font HelveticaNeue do not exists")
            return
        }

        let attributes = AttributeContainer {
            $0.foregroundColor = .red
            $0.font = smallFont
        }
        let attributes1 = AttributeContainer {
            $0.foregroundColor = .green
            $0.font = smallFont
        }
        let attributes2 = AttributeContainer {
            $0.foregroundColor = .blue
            $0.font = bigFont
        }

        let arguments = ["11", "22", "33", "44"]
        let alternatingFormatAttributes = [attributes1, attributes2, attributes1, attributes2]


        it("AttributedString snapshot should match") {
            testAllAttributedStringImplementations(
                format: "%@-%@-%@-%@",
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes,
                imageName: "differentAttributes"
            )
            testAllAttributedStringImplementations(
                format: "%@-%@-%@-%@",
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: [attributes1, attributes1, attributes1, attributes1],
                imageName: "sameAttributes"
            )
            testAllAttributedStringImplementations(
                format: "%1$@-%2$@-%3$@-%4$@",
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes,
                imageName: "explicitIndexInOrder"
            )
            testAllAttributedStringImplementations(
                format: "%4$@-%3$@-%2$@-%1$@",
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes,
                imageName: "explicitIndexReversed"
            )
            testAllAttributedStringImplementations(
                format: "%2$@-%1$@-%@-%@",
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes,
                imageName: "mixedImplicitExplicitOrder"
            )
            testAllAttributedStringImplementations(
                format: "begin 🦁%1$@🦁-🦁%2$@🦁-🦁%3$@🦁-🦁%4$@🦁 end",
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes,
                imageName: "string with emojis"
            )
        }
    }

    @available(iOS 15.0, *)
    private static func testAllAttributedStringImplementations(format: String,
                                                               arguments: [String],
                                                               defaultAttributes: AttributeContainer,
                                                               differentFormatAttributes: [AttributeContainer],
                                                               imageName: String,
                                                               file: StaticString = #file,
                                                               testName: String = #function,
                                                               line: UInt = #line) {
        let attributedString = format.attributedString(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: differentFormatAttributes
        )
        assertAttributedStringSnapshot(attributedString, imageName, file: file, testName: testName, line: line)
        if #available(iOS 16.0, *) {
            let attributedStringUsingRegex = format.attributedStringUsingRegex(
                arguments: arguments,
                defaultAttributes: defaultAttributes,
                differentFormatAttributes: differentFormatAttributes
            )
            assertAttributedStringSnapshot(attributedStringUsingRegex, imageName, file: file, testName: testName, line: line)
        }
        let attributedStringUsingNSRegularExpression = format.attributedStringUsingNSRegularExpression(
            arguments: arguments,
            defaultAttributes: defaultAttributes,
            differentFormatAttributes: differentFormatAttributes
        )
        assertAttributedStringSnapshot(
            attributedStringUsingNSRegularExpression,
            imageName,
            file: file,
            testName: testName,
            line: line
        )
    }

    @available(iOS 15.0, *)
    private static func assertAttributedStringSnapshot(_ attributedString: AttributedString,
                                                       _ imageName: String,
                                                       file: StaticString = #file,
                                                       testName: String = #function,
                                                       line: UInt = #line) {
        let label = Text(attributedString).fixedSize()
        assertSnapshot(matching: label, as: .image, named: imageName, file: file, testName: testName, line: line)
    }
}
