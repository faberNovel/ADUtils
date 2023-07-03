//
//  ViewLayoutTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 16/05/2017.
//
//

import Foundation
import Quick
import ADUtils
import Nimble
import UIKit

class ViewLayout: QuickSpec {

    override class func spec() {

        let veryLongText = "Lorem sizzle pimpin' sit amizzle, yippiyo adipiscing izzle. Nullizzle bling bling velit, away ghetto, suscipit dang, gravida vel, ass. Pellentesque eget tortor. Bow wow wow erizzle. Own yo' uhuh ... yih! sizzle dapibizzle turpis tempus shut the shizzle up. Maurizzle fo shizzle my nizzle crunk et turpizzle. Phat in tortizzle. Fizzle eleifend rhoncizzle i'm in the shizzle. In shut the shizzle up habitasse platea dictumst. Sheezy dapibizzle. Fo tellizzle urna, pretizzle eu, stuff shut the shizzle up, you son of a bizzle boofron, nunc. Fo suscipizzle. Integer sempizzle shizzle my nizzle crocodizzle ass purus"

        let width: CGFloat = 100
        let frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 100.0)

        let addLabelInView = { (view: UIView) in
            let label = UILabel()
            label.numberOfLines = 0
            label.text = veryLongText
            view.addSubview(label)
            label.ad_pinToSuperview()
        }

        let addAutoSizingCollectionView = { (view: UIView) in
            let collectionview = SimpleAutoSizingCollectionView(
                frame: .zero,
                collectionViewLayout: UICollectionViewFlowLayout()
            )
            view.addSubview(collectionview)
            collectionview.ad_pinToSuperview()
        }

        it("should layout regular view") {
            // Given
            let view = UIView(frame: frame)
            addLabelInView(view)
            let expectedHeight = 1218.0
            // When
            let layoutEngineHeight = view.ad_preferredLayoutHeight(fittingWidth: width, computationType: .layoutEngine)
            let autoLayoutHeight = view.ad_preferredLayoutHeight(fittingWidth: width, computationType: .autoLayout)
            // Then
            expect(layoutEngineHeight).to(equal(CGFloat(expectedHeight)))
            expect(autoLayoutHeight).to(equal(CGFloat(expectedHeight)))
        }

        it("should layout UICollectionViewCell") {
            // Given
            let cell = UICollectionViewCell(frame: frame)
            addLabelInView(cell.contentView)
            let expectedHeight = 1218.0
            // When
            let layoutEngineHeight = cell.ad_preferredCellLayoutHeight(
                fittingWidth: width,
                computationType: .layoutEngine
            )
            let autoLayoutHeight = cell.ad_preferredCellLayoutHeight(
                fittingWidth: width,
                computationType: .autoLayout
            )
            // Then
            expect(layoutEngineHeight).to(equal(CGFloat(expectedHeight)))
            expect(autoLayoutHeight).to(equal(CGFloat(expectedHeight)))
        }

        it("should layout UITableViewCell") {
            // Given
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.frame = frame
            addLabelInView(cell.contentView)
            let expectedHeight = 1218.0
            // When
            let layoutEngineHeight = cell.ad_preferredCellLayoutHeight(
                fittingWidth: width,
                computationType: .layoutEngine
            )
            let autoLayoutHeight = cell.ad_preferredCellLayoutHeight(fittingWidth: width, computationType: .autoLayout)
            // Then
            expect(layoutEngineHeight).to(equal(CGFloat(expectedHeight)))
            expect(autoLayoutHeight).to(equal(CGFloat(expectedHeight)))
        }

        it("should layout UITableViewHeaderFooterView") {
            // Given
            let headerFooter = UITableViewHeaderFooterView(reuseIdentifier: nil)
            headerFooter.frame = frame
            addLabelInView(headerFooter.contentView)
            let expectedHeight = 1218.0
            // When
            let height = headerFooter.ad_preferredContentViewLayoutHeight(fittingWidth: width)
            let layoutEngineHeight = headerFooter.ad_preferredContentViewLayoutHeight(
                fittingWidth: width,
                computationType: .layoutEngine
            )
            let autoLayoutHeight = headerFooter.ad_preferredContentViewLayoutHeight(
                fittingWidth: width,
                computationType: .autoLayout
            )
            // Then
            expect(layoutEngineHeight).to(equal(CGFloat(expectedHeight)))
            expect(autoLayoutHeight).to(equal(CGFloat(expectedHeight)))
        }

        it("should layout UITableViewCell using autolayout computation with auto sizing collectionview") {
            // Given
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.frame = frame
            addAutoSizingCollectionView(cell.contentView)
            let expectedHeight = 308
            // When
            let layoutEngineHeight = cell.ad_preferredCellLayoutHeight(
                fittingWidth: width,
                computationType: .layoutEngine
            )
            let autoLayoutHeight = cell.ad_preferredCellLayoutHeight(fittingWidth: width, computationType: .autoLayout)
            // Then
            expect(layoutEngineHeight).to(equal(CGFloat(0)))
            expect(autoLayoutHeight).to(equal(CGFloat(expectedHeight)))
        }

        it("should not alter contentView of a UICollectionViewCell") {
            // Given
            let cell = UICollectionViewCell(frame: frame)
            addLabelInView(cell.contentView)
            let previousContentFrame = cell.contentView.frame
            let previousContentConstraints = cell.contentView.constraints
            // When
            _ = cell.ad_preferredCellLayoutHeight(fittingWidth: width)
            // Then
            expect(cell.contentView.frame).to(equal(previousContentFrame))
            expect(cell.contentView.constraints).to(equal(previousContentConstraints))
        }

        it("should not alter contentView of a UITableViewCell") {
            // Given
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            addLabelInView(cell.contentView)
            let previousContentFrame = cell.contentView.frame
            let previousContentConstraints = cell.contentView.constraints
            // When
            _ = cell.ad_preferredCellLayoutHeight(fittingWidth: width)
            // Then
            expect(cell.contentView.frame).to(equal(previousContentFrame))
            expect(cell.contentView.constraints).to(equal(previousContentConstraints))
        }

        it("should not alter contentView of a UITableViewHeaderFooterView") {
            // Given
            let cell = UITableViewHeaderFooterView(reuseIdentifier: nil)
            addLabelInView(cell.contentView)
            let previousContentFrame = cell.contentView.frame
            let previousContentConstraints = cell.contentView.constraints
            // When
            _ = cell.ad_preferredContentViewLayoutHeight(fittingWidth: width)
            // Then
            expect(cell.contentView.frame).to(equal(previousContentFrame))
            expect(cell.contentView.constraints).to(equal(previousContentConstraints))
        }
    }
}
