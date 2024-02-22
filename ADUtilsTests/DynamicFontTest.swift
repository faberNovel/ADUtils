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

    class func ad_systemFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return FontHelper.shared.systemFont.font(forTextStyle: textStyle)
    }
}

private extension Font {

    static func ad_mainFont(forTextStyle textStyle: Font.TextStyle) -> Font {
        return FontHelper.shared.helveticaNeueDynamicFont.font(forTextStyle: textStyle)
    }

    static func ad_systemFont(forTextStyle textStyle: Font.TextStyle) -> Font {
        return FontHelper.shared.systemFont.font(forTextStyle: textStyle)
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

    lazy var systemFont: DynamicFont = {
        do {
            return try DynamicFont(fontName: "SystemFont", in: Bundle(for: type(of: self)))
        } catch {
            assertionFailure("Unable to create systemFont")
            return DynamicFont()
        }
    }()
}

@MainActor
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

            it("should layout labels properly") {
                let labels = types.map { (type) -> UILabel in
                    let label = UILabel()
                    label.font = UIFont.ad_mainFont(forTextStyle: type)
                    label.adjustsFontForContentSizeCategory = true
                    label.text = "Lorem sizzle pimpin' sit amizzle"
                    label.numberOfLines = 0
                    return label
                }

                let stackView = UIStackView(arrangedSubviews: labels)
                stackView.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 1000.0)
                stackView.axis = .vertical
                stackView.distribution = .fillEqually

                stackView.layoutIfNeeded()
                assertSnapshot(matching: stackView, as: .image, named: "DynamicFontLayoutTest")
                assertSnapshot(
                    matching: stackView,
                    as: .image(traits: UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)),
                    named: "DynamicFontLayoutXXLTest"
                )
            }

            it("should render system font properly") {
                let labels = types.map { (type) -> UILabel in
                    let label = UILabel()
                    label.font = UIFont.ad_systemFont(forTextStyle: type)
                    label.adjustsFontForContentSizeCategory = true
                    label.text = "Lorem sizzle pimpin' sit amizzle"
                    label.numberOfLines = 0
                    return label
                }

                let stackView = UIStackView(arrangedSubviews: labels)
                stackView.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 1000.0)
                stackView.axis = .vertical
                stackView.distribution = .fillEqually

                stackView.layoutIfNeeded()
                assertSnapshot(matching: stackView, as: .image, named: "SystemFontLayoutTest")
                assertSnapshot(
                    matching: stackView,
                    as: .image(traits: UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)),
                    named: "SystemFontLayoutXXLTest"
                )
            }
        }

        describe("display SwiftUI fonts") {

            struct DynamicFontsView: View {

                let fontProvider: (Font.TextStyle) -> Font

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
                            Text("Lorem sizzle pimpin' sit amizzle").font(fontProvider(types[index]))
                        }
                    }
                }
            }
            it("should layout labels properly") {
                let view = DynamicFontsView(fontProvider: { .ad_mainFont(forTextStyle: $0) })
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
            }

            it("should render system font properly") {
                let view = DynamicFontsView(fontProvider: { .ad_systemFont(forTextStyle: $0) })
                assertSnapshot(
                    matching: view,
                    as: .image(layout: .fixed(width: 200, height: 1000)),
                    named: "SwiftUISystemFontLayoutTest"
                )
                assertSnapshot(
                    matching: view,
                    as: .image(
                        layout: .fixed(width: 200, height: 1000),
                        traits: UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)
                    ),
                    named: "SwiftUISystemFontLayoutXXLTest"
                )
            }
        }
    }
}
