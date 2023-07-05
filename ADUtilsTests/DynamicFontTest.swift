//
//  DynamicFontTest.swift
//  ADUtilsTests
//
//  Created by Benjamin Lavialle on 25/10/2017.
//

import UIKit
import SwiftUI
import Quick
import ADUtils
import Nimble
import SnapshotTesting

private extension UIFont {

    class func ad_mainFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return FontHelper.shared.helveticaNeueDynamicFont.font(forTextStyle: textStyle)
    }
}

private extension Font {

    static func ad_mainFont(forTextStyle textStyle: Font.TextStyle) -> Font {
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

    override class func spec() {

        describe("display UIKit fonts") {

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
                assertSnapshot(matching: stackView, as: .image, named: "DynamicFontLayoutTest")
                assertSnapshot(
                    matching: stackView,
                    as: .image(traits: UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)),
                    named: "DynamicFontLayoutXXLTest"
                )
            }
        }

        describe("display SwiftUI fonts") {

            @available(iOS 14.0, *)
            struct DynamicFontsView: View {

                let types: [Font.TextStyle] = [
                    .title,
                    .title2,
                    .title3,
                    .headline,
                    .subheadline,
                    .body,
                    .callout,
                    .footnote,
                    .caption,
                    .caption2
                ]

                var body: some View {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(types.indices, id: \.self) { index in
                            Text("Lorem sizzle pimpin' sit amizzle").font(.ad_mainFont(forTextStyle: types[index]))
                        }
                    }
                }
            }
            it("should layout labels properly") {
                if #available(iOS 14.0, *) {
                    let view = DynamicFontsView()
                    assertSnapshot(
                        matching: view,
                        as: .image(layout: .fixed(width: 200, height: 1000)),
                        named: "SwiftUIDynamicFontLayoutTest"
                    )
                    assertSnapshot(
                        matching: view,
                        as: .image(
                            layout: .fixed(width: 200, height: 1000),
                            traits: UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)
                        ),
                        named: "SwiftUIDynamicFontLayoutXXLTest"
                    )
                } else {
                    throw XCTSkip("title2, title3, caption2 are only available on iOS 14")
                }
            }
        }
    }
}
