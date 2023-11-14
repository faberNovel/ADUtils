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
import ADUtils
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

        func assertAttributedStringSnapshot(_ attributedString: AttributedString,
                                            _ imageName: String,
                                            file: StaticString = #file,
                                            line: UInt = #line) {
            let label = Text(attributedString).fixedSize()
            assertSnapshot(matching: label, as: .image, named: imageName, file: file, line: line)
        }

        guard
            let smallFont = UIFont(name: "HelveticaNeue", size: 12.0),
            let bigFont = UIFont(name: "HelveticaNeue", size: 24.0) else {
            fail("Font HelveticaNeue do not exists")
            return
        }

        var attributes = AttributeContainer()
        attributes.foregroundColor = .red
        attributes.font = smallFont
        var attributes1 = AttributeContainer()
        attributes1.foregroundColor = .green
        attributes1.font = smallFont
        var attributes2 = AttributeContainer()
        attributes2.foregroundColor = .blue
        attributes2.font = bigFont

        let arguments = ["11", "22", "33", "44"]
        let alternatingFormatAttributes = [attributes1, attributes2, attributes1, attributes2]

        it("AttributedString  snapshot should match") {
            let attributedString1 = "%@-%@-%@-%@".attributedString(
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes
            )
            assertAttributedStringSnapshot(attributedString1, "differentAttributes")
            let attributedString2 = "%@-%@-%@-%@".attributedString(
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: [attributes1, attributes1, attributes1, attributes1]
            )
            assertAttributedStringSnapshot(attributedString2, "sameAttributes")
            let attributedString3 = "%1$@-%2$@-%3$@-%4$@".attributedString(
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes
            )
            assertAttributedStringSnapshot(attributedString3, "explicitIndexInOrder")
            let attributedString4 = "%4$@-%3$@-%2$@-%1$@".attributedString(
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes
            )
            assertAttributedStringSnapshot(attributedString4, "explicitIndexReversed")
            let attributedString5 = "%2$@-%1$@-%@-%@".attributedString(
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes
            )
            assertAttributedStringSnapshot(attributedString5, "mixedImplicitExplicitOrder")
            let attributedString6 = "begin 🦁%1$@🦁-🦁%2$@🦁-🦁%3$@🦁-🦁%4$@🦁 end".attributedString(
                arguments: arguments,
                defaultAttributes: attributes,
                differentFormatAttributes: alternatingFormatAttributes
            )
            assertAttributedStringSnapshot(attributedString6, "string with emojis")
        }
    }
}
