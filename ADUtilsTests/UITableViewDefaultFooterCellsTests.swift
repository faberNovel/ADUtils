//
//  UITableView+DefaultFooterCellsTests.swift
//  ADUtilsTests
//
//  Created by Gaétan Zanella on 27/03/2020.
//

import Foundation
import Nimble
import Quick
import ADUtils

class UITableViewDefaultFooterCellsTests: QuickSpec {

    override class func spec() {

        it("should have an empty footer") {
            // Given
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.ad_hideDefaultFooterCells()

            // Then
            expect(tableView.tableFooterView).toNot(beNil())
        }

        it("should not have an empty footer") {
            // Given
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.ad_hideDefaultFooterCells()

            // Then
            expect(tableView.tableFooterView).to(beNil())
        }
    }
}
