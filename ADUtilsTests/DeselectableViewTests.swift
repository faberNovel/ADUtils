//
//  DeselectableViewTests.swift
//  ADUtilsTests
//
//  Created by Pierre Felgines on 01/10/2018.
//

import Foundation
import Nimble
import Quick
import ADUtils

private class TransitionCoordinator: NSObject, UIViewControllerTransitionCoordinator {

    var isAnimated: Bool { return false }

    var presentationStyle: UIModalPresentationStyle { return .none }

    var initiallyInteractive: Bool { return false }

    var isInterruptible: Bool { return false }

    var isInteractive: Bool { return false }

    var isCancelled = false

    var transitionDuration: TimeInterval { return 0.0 }

    var percentComplete: CGFloat { return 1.0 }

    var completionVelocity: CGFloat { return 0 }

    var completionCurve: UIView.AnimationCurve { return .easeIn }

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return nil
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return nil
    }

    var containerView: UIView { return UIView() }

    var targetTransform: CGAffineTransform { return .identity }

    func animate(alongsideTransition animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        animation?(self)
        completion?(self)
        return true
    }

    func animateAlongsideTransition(in view: UIView?, animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        animation?(self)
        completion?(self)
        return true
    }

    func notifyWhenInteractionEnds(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {
        // no op
    }

    func notifyWhenInteractionChanges(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {
        // no op
    }
}

class DeselectableViewTests: QuickSpec {

    override class func spec() {

        let selectedIndexPath = IndexPath(row: 0, section: 0)
        var transitionCoordinator: TransitionCoordinator!

        beforeEach {
            transitionCoordinator = TransitionCoordinator()
        }

        describe("UITableView") {

            var tableView: UITableView!
            var tableViewDataSource: TableViewDataSource!

            beforeEach {
                tableView = UITableView()
                tableViewDataSource = TableViewDataSource()
                tableView.dataSource = tableViewDataSource
                tableView.reloadData()

                // Given
                tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
                expect((tableView.selectedIndexPaths ?? []).map { $0.row }).to(equal([0]))
            }

            it("should deselect indexPath if coordinator nil") {
                // When
                tableView.ad_smoothlyDeselectItems(in: nil)

                // Then
                expect((tableView.selectedIndexPaths ?? [])).to(beEmpty())
            }

            it("should deselect indexPath if coordinator not nil") {
                // When
                tableView.ad_smoothlyDeselectItems(in: transitionCoordinator)

                // Then
                expect((tableView.selectedIndexPaths ?? [])).to(beEmpty())
            }

            it("should not deselect indexPath if coordinator is canceled") {
                // Given
                transitionCoordinator.isCancelled = true

                // When
                tableView.ad_smoothlyDeselectItems(in: transitionCoordinator)

                // Then
                expect((tableView.selectedIndexPaths ?? []).map { $0.row }).to(equal([0]))
            }
        }

        describe("UICollectionView") {

            var collectionView: UICollectionView!
            var collectionViewDataSource: CollectionViewDataSource!

            beforeEach {
                let layout = UICollectionViewFlowLayout()
                collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                collectionViewDataSource = CollectionViewDataSource()
                collectionViewDataSource.registerCells(collectionView)
                collectionView.dataSource = collectionViewDataSource
                collectionView.reloadData()

                // Given
                collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
                expect((collectionView.selectedIndexPaths ?? []).map { $0.item }).to(equal([0]))
            }

            it("should deselect indexPath if coordinator nil") {
                // When
                collectionView.ad_smoothlyDeselectItems(in: nil)

                // Then
                expect((collectionView.selectedIndexPaths ?? [])).to(beEmpty())
            }

            it("should deselect indexPath if coordinator not nil") {
                // When
                collectionView.ad_smoothlyDeselectItems(in: transitionCoordinator)

                // Then
                expect((collectionView.selectedIndexPaths ?? [])).to(beEmpty())
            }

            it("should not deselect indexPath if coordinator is canceled") {
                // Given
                transitionCoordinator.isCancelled = true

                // When
                collectionView.ad_smoothlyDeselectItems(in: transitionCoordinator)

                // Then
                expect((collectionView.selectedIndexPaths ?? []).map { $0.item }).to(equal([0]))
            }
        }
    }
}
