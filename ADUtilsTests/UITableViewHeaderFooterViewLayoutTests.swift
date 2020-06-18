//
//  UITableViewHeaderFooterViewLayoutTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 04/05/2020.
//

import Foundation
import UIKit
import Nimble
import Quick
import ADUtils

class DemoHeaderFooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    // MARK: - Private

    private func setUp() {
        let subView = UIView()
        subView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        addSubview(subView)
        subView.ad_pinToSuperview()
    }
}

enum ExtremityViewType {
    case header
    case footer
}

extension UITableView {

    func extremityView(for type: ExtremityViewType) -> UIView? {
        switch type {
        case .header:
            return tableHeaderView
        case .footer:
            return tableFooterView
        }
    }

    func setExtremityView(_ view: UIView?, for type: ExtremityViewType) {
        switch type {
        case .header:
            ad_setAndLayoutTableHeaderView(view)
        case .footer:
            ad_setAndLayoutTableFooterView(view)
        }
    }
}

class HeaderFooterBehavior: Behavior<ExtremityViewType> {

    override class func spec(_ context: @escaping () -> ExtremityViewType) {
        var viewType: ExtremityViewType!

        beforeEach {
            viewType = context()
        }

        it("should set and layout the extremity view") {
            // Given
            let tableView = UITableView(
                frame: CGRect(origin: .zero, size: CGSize(width: 320.0, height: 528.0)),
                style: .plain
            )
            expect(tableView.extremityView(for: viewType)).to(beNil())
            let extremityView = DemoHeaderFooterView()
            expect(extremityView.frame).to(equal(CGRect.zero))

            // When
            tableView.setExtremityView(extremityView, for: viewType)

            // Then
            expect(tableView.extremityView(for: viewType)).toNot(beNil())
            let bounds = CGRect(
                origin: .zero,
                size: CGSize(width: 320.0, height: 200.0)
            )
            expect(extremityView.frame).to(equal(bounds))
        }
    }
}


class UITableViewHeaderFooterViewLayoutTests: QuickSpec {

    override func spec() {
        itBehavesLike(HeaderFooterBehavior.self) { .header }
        itBehavesLike(HeaderFooterBehavior.self) { .footer }
    }
}
