//
//  UIImageColorTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 15/02/2021.
//

import Foundation
import Nimble
import Quick
import ADUtils
import SnapshotTesting

@MainActor
class UIImageColorTests: QuickSpec {

    override class func spec() {

        it("should have correct snapshot with size") {
            // Given
            let size = CGSize(width: 10, height: 20)
            let color = UIColor.red

            // When
            let image = UIImage.ad_filled(with: color, size: size)

            // Then
            let imageView = UIImageView(image: image)
            assertSnapshot(matching: imageView, as: .image, named: "UIImageColorRedWithSize")
        }

        it("should have correct snapshot without size") {
            // Given
            let color = UIColor.red

            // When
            let image = UIImage.ad_filled(with: color)

            // Then
            let imageView = UIImageView(image: image)
            assertSnapshot(matching: imageView, as: .image, named: "UIImageColorRedPixel")
        }

        it("should have correct snapshot with scale") {
            // Given
            let size = CGSize(width: 10, height: 20)
            let scale: CGFloat = 3.0
            let color = UIColor.red

            // When
            let image = UIImage.ad_filled(with: color, size: size, scale: scale)

            // Then
            XCTAssertEqual(image?.scale, 3.0)
            XCTAssertEqual(image?.size, size)
            let imageView = UIImageView(image: image)
            assertSnapshot(matching: imageView, as: .image(traits: UITraitCollection(displayScale: scale)), named: "UIImageColorRedWithScale")
        }

        if #available(iOS 13.0, *) {

            it("should create images for light and dark modes") {
                // Given
                let color = UIColor { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return .blue
                    case .light,
                         .unspecified:
                            return .red
                    @unknown default:
                        fatalError("Case not handled")
                    }
                }
                let size = CGSize(width: 10, height: 20)

                // When
                let image = UIImage.ad_filled(with: color, size: size)

                // Then
                // Can't create a snapshot test case here, as userInterfaceStyle is not working in XCTest
                // cf https://github.com/uber/ios-snapshot-test-case/issues/122
                expect(image).toNot(beNil())
                expect(image?.imageAsset).toNot(beNil())
                let lightImage = image?.imageAsset?.image(with: UITraitCollection(userInterfaceStyle: .light))
                let darkImage = image?.imageAsset?.image(with: UITraitCollection(userInterfaceStyle: .dark))
                expect(lightImage).toNot(beNil())
                expect(darkImage).toNot(beNil())
                expect(lightImage).toNot(equal(darkImage))
            }
        }
    }
}
