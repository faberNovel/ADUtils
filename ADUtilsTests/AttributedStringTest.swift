//
//  AttributedStringTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation
import Nimble
import Nimble_Snapshots
import Quick
import ADUtils
@testable import ADUtilsApp

class AttributedStringTest: QuickSpec {

    override func spec() {

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
            expect(label).to(haveValidSnapshot(named: imageName))
        }

        it("Snapshots should match") {
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
    }
}
