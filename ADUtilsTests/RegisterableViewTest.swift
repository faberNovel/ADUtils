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

class TableViewHeader : UITableViewHeaderFooterView {}
class TableViewFooter : UITableViewHeaderFooterView {}

class CollectionViewDataSource : NSObject, UICollectionViewDataSource {

    /*
     * We cannot just create a UICollectionView and register / dequeue cells
     * Thus we just test compilation creating a datasource that uses all features of
     * registerable views.
     *
     */

    func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(cell: .class(UICollectionViewCell.self))
        collectionView.register(header: .class(CollectionViewHeader.self))
        collectionView.register(footer: .class(CollectionViewFooter.self))
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueCellAt(indexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header: CollectionViewHeader = collectionView.dequeueHeaderAt(indexPath: indexPath)
            return header
        case UICollectionElementKindSectionFooter:
            let footer: CollectionViewFooter = collectionView.dequeueFooterAt(indexPath: indexPath)
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
            let indexPath = IndexPath(row: 0, section: 0)

            beforeEach {
                tableView = UITableView()
                tableView.dataSource = simpleDataSource
            }

            it("Should register cell class and get not nil instance back") {
                let registerableView = RegisterableView.class(UITableViewCell.self)
                tableView.register(cell: registerableView)

                let cell: UITableViewCell = tableView.dequeueCellAt(indexPath: indexPath)
                expect(cell).toNot(beNil())
            }

            it("Should register header class and get not nil instance back") {
                tableView.register(header: .class(TableViewHeader.self))
                tableView.register(footer: .class(TableViewFooter.self))

                let header: TableViewHeader = tableView.dequeueHeader()
                let footer: TableViewFooter = tableView.dequeueFooter()
                expect(header).toNot(beNil())
                expect(footer).toNot(beNil())
            }
        }
    }
}
