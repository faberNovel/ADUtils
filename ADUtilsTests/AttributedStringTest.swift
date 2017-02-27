//
//  AttributedStringTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation

import Foundation
import Nimble
import Nimble_Snapshots
import Quick
import ADUtils
@testable import ADUtilsApp

class AttributedStringTest: QuickSpec {

    override func spec() {

        let stringTest = { (string: String, arguments: [String], imageName: String) -> Void in

            let attributes = [
                NSForegroundColorAttributeName: UIColor.redColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(12.0)
            ]
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.greenColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(12.0)
            ]
            let attributes2 = [
                NSForegroundColorAttributeName: UIColor.blueColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(24.0)
            ]

            let differentFormatAttributes = arguments.enumerate().map({ (index, _) -> [String: AnyObject] in
                return [attributes1, attributes2][index % 2]
            })


            let attributedString = string.attributedString(
                withArguments: arguments,
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
        }
    }
}
