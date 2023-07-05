//
//  StackViewBuilderTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 17/03/2021.
//

import Foundation
import Nimble
import Quick
import ADUtils
import SnapshotTesting

private extension UIView {
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        backgroundColor = color
    }
}

class StackViewBuilderTests: QuickSpec {

    override class func spec() {

        describe("HStackView") {

            it("should have correct snapshot with default parameters") {
                // Given
                let redView = UIView(color: .red)
                let greenView = UIView(color: .green)
                greenView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true

                // When
                let stackView = HStackView {
                    redView
                    greenView
                }
                stackView.frame = CGRect(
                    origin: .zero,
                    size: CGSize(width: 100.0, height: 50.0)
                )

                // Then
                assertSnapshot(matching: stackView, as: .image, named: "HStackViewDefault")
            }

            it("should have correct snapshot with custom parameters") {
                // Given
                let redView = UIView(color: .red)
                let greenView = UIView(color: .green)
                [redView, greenView].forEach {
                    $0.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
                }

                // When
                let stackView = HStackView(spacing: 10, alignment: .center, distribution: .fillEqually) {
                    redView
                    greenView
                }
                stackView.frame = CGRect(
                    origin: .zero,
                    size: CGSize(width: 100.0, height: 50.0)
                )

                // Then
                assertSnapshot(matching: stackView, as: .image, named: "HStackViewCustom")
            }

        } // HStackView

        describe("VStackView") {

            it("should have correct snapshot with default parameters") {
                // Given
                let redView = UIView(color: .red)
                let greenView = UIView(color: .green)
                greenView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true

                // When
                let stackView = VStackView {
                    redView
                    greenView
                }
                stackView.frame = CGRect(
                    origin: .zero,
                    size: CGSize(width: 50.0, height: 100.0)
                )

                // Then
                assertSnapshot(matching: stackView, as: .image, named: "VStackViewDefault")
            }

            it("should have correct snapshot with custom parameters") {
                // Given
                let redView = UIView(color: .red)
                let greenView = UIView(color: .green)
                [redView, greenView].forEach {
                    $0.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
                }

                // When
                let stackView = VStackView(spacing: 10, alignment: .center, distribution: .fillEqually) {
                    redView
                    greenView
                }
                stackView.frame = CGRect(
                    origin: .zero,
                    size: CGSize(width: 50.0, height: 100.0)
                )

                // Then
                assertSnapshot(matching: stackView, as: .image, named: "VStackViewCustom")
            }

        } // VStackView

    }
}
