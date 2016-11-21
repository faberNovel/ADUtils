//
//  ViewInsertionWithMarginTest.swift
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

class ViewInsertionWithMargin: QuickSpec {

    override func spec() {
        it("Snapshots should match") {
            let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
            let subView = UIView()
            subView.backgroundColor = UIColor.redColor()
            view.ad_addSubview(subView, withMargins: UIEdgeInsets(top: 12.0, left: 13.0, bottom: 20.0, right: 45.0))

            expect(view).to(haveValidSnapshot(named: "ViewInsertionWithMargin"))
        }
    }
}
