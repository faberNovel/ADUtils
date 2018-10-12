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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class NibTableViewCell: UITableViewCell {}
class TableViewHeader : UITableViewHeaderFooterView {}
class TableViewFooter : UITableViewHeaderFooterView {}
class NibTableHeaderView: UITableViewHeaderFooterView {}

class CollectionViewDataSource : NSObject, UICollectionViewDataSource {

    /*
     * We cannot just create a UICollectionView and register / dequeue cells
     * Thus we just test compilation creating a datasource that uses all features of
     * registerable views.
     *
     */

    func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(
            cells: [
                .class(UICollectionViewCell.self),
                .class(CollectionViewCell.self),
                .nib(NibCollectionViewCell.self)
            ]
        )
        collectionView.register(
            headers: [
                .class(CollectionViewHeader.self),
                .class(UICollectionReusableView.self)
            ]
        )
        collectionView.register(
            footers: [
                .class(CollectionViewFooter.self),
                .class(UICollectionReusableView.self)
            ]
        )
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueCell(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header: CollectionViewHeader = collectionView.dequeueHeader(at: indexPath)
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer: CollectionViewFooter = collectionView.dequeueFooter(at: indexPath)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}

class CollectionViewCell: UICollectionViewCell {}
class NibCollectionViewCell: UICollectionViewCell {}
class CollectionViewHeader : UICollectionReusableView {}
class CollectionViewFooter : UICollectionReusableView {}

class RegisterableViewTest: QuickSpec {

    override func spec() {

        describe("UITableView") {

            let simpleDataSource = TableViewDataSource()
            var tableView = UITableView()
            let indexPath = IndexPath(row: 0, section: 0)

            beforeEach {
                tableView = UITableView()
                tableView.dataSource = simpleDataSource
            }

            it("Should register cell class and get not nil instance back") {
                tableView.register(
                    cells: [
                        .class(UITableViewCell.self),
                        .nib(NibTableViewCell.self)
                    ]
                )

                let cell: UITableViewCell = tableView.dequeueCell(at: indexPath)
                expect(cell).toNot(beNil())
                let nibCell: NibTableViewCell = tableView.dequeueCell(at: indexPath)
                expect(nibCell).toNot(beNil())
            }

            it("Should register header class and get not nil instance back") {
                tableView.register(header: .class(TableViewHeader.self))
                tableView.register(footer: .class(TableViewFooter.self))
                tableView.register(header: .nib(NibTableHeaderView.self))

                let header: TableViewHeader = tableView.dequeueHeader()
                expect(header).toNot(beNil())
                let nibHeader: NibTableHeaderView = tableView.dequeueHeader()
                expect(nibHeader).toNot(beNil())
                let footer: TableViewFooter = tableView.dequeueFooter()
                expect(footer).toNot(beNil())
            }
        }

        describe("UICollectionView") {

            var simpleDataSource: CollectionViewDataSource!
            var collectionView: UICollectionView!
            let indexPath = IndexPath(row: 0, section: 0)

            beforeEach {
                simpleDataSource = CollectionViewDataSource()
                let layout = UICollectionViewFlowLayout()
                let rect = CGRect(x: 0, y: 0, width: 320, height: 1000)
                collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
                collectionView.dataSource = simpleDataSource
                simpleDataSource.registerCells(collectionView)
                collectionView.reloadData()
                collectionView.layoutIfNeeded()
            }

            it("should register cell class and get not nil instance back") {
                let cell: UICollectionViewCell = collectionView.dequeueCell(at: indexPath)
                expect(cell).toNot(beNil())

                let nibCell: NibCollectionViewCell = collectionView.dequeueCell(at: indexPath)
                expect(nibCell).toNot(beNil())
            }

            it("should register header class and get not instance back") {
                let header: CollectionViewHeader = collectionView.dequeueHeader(at: indexPath)
                expect(header).toNot(beNil())

                let footer: CollectionViewFooter = collectionView.dequeueFooter(at: indexPath)
                expect(footer).toNot(beNil())
            }
        }
    }
}
