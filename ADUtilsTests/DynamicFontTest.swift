//
//  DynamicFontTest.swift
//  ADUtilsTests
//
//  Created by Benjamin Lavialle on 25/10/2017.
//

import Foundation
import Quick
import ADUtils
import Nimble
import Nimble_Snapshots

private extension UIFont {

    class func ad_mainFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return FontHelper.shared.helveticaNeueDynamicFont.font(forTextStyle: textStyle)
    }
}

private class FontHelper {

    static let shared = FontHelper()

    lazy var helveticaNeueDynamicFont: DynamicFont = {
        do {
            return try DynamicFont(fontName: "HelveticaNeue", in: Bundle(for: type(of: self)))
        } catch {
            assertionFailure("Unable to create helveticaNeueDynamicFont")
            return DynamicFont()
        }
    }()
}

class DynamicFontTest: QuickSpec {

    override func spec() {

        describe("display fonts") {

            let types: [UIFont.TextStyle] = [
                .title1,
                .title2,
                .title3,
                .headline,
                .subheadline,
                .body,
                .callout,
                .footnote,
                .caption1,
                .caption2
            ]
            let labels = types.map { (type) -> UILabel in
                let label = UILabel()
                label.font = UIFont.ad_mainFont(forTextStyle: type)
                if #available(iOS 11.0, *) {
                    label.adjustsFontForContentSizeCategory = true
                }
                label.text = "Lorem sizzle pimpin' sit amizzle"
                label.numberOfLines = 0
                return label
            }

            let stackView = UIStackView(arrangedSubviews: labels)
            stackView.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 1000.0)
            stackView.axis = .vertical
            stackView.distribution = .fillEqually

            it("should layout labels properly") {
                stackView.layoutIfNeeded()
                expect(stackView).to(haveValidSnapshot(named: "DynamicFontLayoutTest"))
            }
        }
    }
}
