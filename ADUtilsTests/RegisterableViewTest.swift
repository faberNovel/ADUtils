//
//  RegisterableViewTest.swift
//  ADUtils
//
//  Created by Pierre Felgines on 24/11/16.
//
//

import Foundation
import Quick
import Nimble
import ADUtils

class TableViewDataSource : NSObject, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class TableViewHeader : UITableViewHeaderFooterView {}
class TableViewFooter : UITableViewHeaderFooterView {}

class CollectionViewDataSource : NSObject, UICollectionViewDataSource {

    /*
     * We cannot just create a UICollectionView and register / dequeue cells
     * Thus we just test compilation creating a datasource that uses all features of
     * registerable views.
     *
     */

    func registerCells(collectionView: UICollectionView) {
        collectionView.registerCell(.Class(UICollectionViewCell.self))
        collectionView.registerHeader(.Class(CollectionViewHeader.self))
        collectionView.registerFooter(.Class(CollectionViewFooter.self))
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueCellAtIndexPath(indexPath)
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header: CollectionViewHeader = collectionView.dequeueHeaderAtIndexPath(indexPath)
            return header
        case UICollectionElementKindSectionFooter:
            let footer: CollectionViewFooter = collectionView.dequeueFooterAtIndexPath(indexPath)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}

class CollectionViewHeader : UICollectionReusableView {}
class CollectionViewFooter : UICollectionReusableView {}

class RegisterableViewTest: QuickSpec {

    override func spec() {

        describe("UITableView") {

            let simpleDataSource = TableViewDataSource()
            var tableView = UITableView()
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)

            beforeEach {
                tableView = UITableView()
                tableView.dataSource = simpleDataSource
            }

            it("Should register cell class and get not nil instance back") {
                let registerableView = RegisterableView.Class(UITableViewCell.self)
                tableView.registerCell(registerableView)

                let cell: UITableViewCell = tableView.dequeueCellAtIndexPath(indexPath)
                expect(cell).toNot(beNil())
            }

            it("Should register header class and get not nil instance back") {
                tableView.registerHeader(.Class(TableViewHeader.self))
                tableView.registerFooter(.Class(TableViewFooter.self))

                let header: TableViewHeader = tableView.dequeueHeader()
                let footer: TableViewFooter = tableView.dequeueFooter()
                expect(header).toNot(beNil())
                expect(footer).toNot(beNil())
            }
        }
    }
}
