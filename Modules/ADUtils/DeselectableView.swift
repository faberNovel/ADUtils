//
//  DeselectorView.swift
//  BabolatPulse
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation
import UIKit

/**
 * This is a protocol to factorize table and collection view selection methods
 */

protocol DeselectableView: class {
    var selectedIndexPaths: [IndexPath]? { get }
    func deselect(atIndexPath indexPath: IndexPath, animated: Bool)
    func select(atIndexPath indexPath: IndexPath, animated: Bool)
}

extension DeselectableView where Self: UIView {

    //MARK: - DeselectableView

    /**
     Smoothly deselects item in DeselectableView (ie UITableView/UICollectionView) along coordinator's transition

     Should be used inside viewWillAppear :

     ```
     override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.smoothlyDeselectItems(in: transitionCoordinator)
     }
     ```

     - parameter coordinator: UIViewControllerTransitionCoordinator
     */
    func smoothlyDeselectItems(in coordinator: UIViewControllerTransitionCoordinator?) {
        guard let selectedIndexPaths = selectedIndexPaths else { return }
        guard let coordinator = coordinator else {
            deselect(atIndexPaths: selectedIndexPaths, animated: false)
            return
        }

        coordinator.animateAlongsideTransition(
            in: self,
            animation: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
                self?.deselect(atIndexPaths: selectedIndexPaths, animated: true)
            },
            completion: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
                guard context.isCancelled else {
                    return
                }
                self?.select(atIndexPaths: selectedIndexPaths, animated: false)
            }
        )
    }

    //MARK: - Private

    private func select(atIndexPaths indexPaths: [IndexPath], animated: Bool) {
        for indexPath in indexPaths {
            select(atIndexPath: indexPath, animated: animated)
        }
    }

    private func deselect(atIndexPaths indexPaths: [IndexPath], animated: Bool) {
        for indexPath in indexPaths {
            deselect(atIndexPath: indexPath, animated: animated)
        }
    }
}

extension UITableView: DeselectableView {

    public var selectedIndexPaths: [IndexPath]? {
        return indexPathsForSelectedRows
    }

    public func deselect(atIndexPath indexPath: IndexPath, animated: Bool) {
        deselectRow(at: indexPath, animated: animated)
    }

    public func select(atIndexPath indexPath: IndexPath, animated: Bool) {
        selectRow(at: indexPath, animated: animated, scrollPosition: .none)
    }
}

extension UICollectionView: DeselectableView {

    public var selectedIndexPaths: [IndexPath]? {
        return indexPathsForSelectedItems
    }

    public func deselect(atIndexPath indexPath: IndexPath, animated: Bool) {
        deselectItem(at: indexPath, animated: animated)
    }

    public func select(atIndexPath indexPath: IndexPath, animated: Bool) {
        selectItem(at: indexPath, animated: animated, scrollPosition: .top)
    }
}

public extension UITableView {

    /**
     Smoothly deselects item in UITableView along coordinator's transition

     Should be used inside viewWillAppear :

     ```
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.ad_smoothlyDeselectItems(in: transitionCoordinator)
     }
     ```

     - parameter coordinator: UIViewControllerTransitionCoordinator
     */
    func ad_smoothlyDeselectItems(in coordinator: UIViewControllerTransitionCoordinator?) {
        smoothlyDeselectItems(in: coordinator)
    }
}

public extension UICollectionView {

    /**
     Smoothly deselects item in UICollectionView along coordinator's transition

     Should be used inside viewWillAppear :

     ```
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.ad_smoothlyDeselectItems(in: transitionCoordinator)
     }
     ```

     - parameter coordinator: UIViewControllerTransitionCoordinator
     */
    func ad_smoothlyDeselectItems(in coordinator: UIViewControllerTransitionCoordinator?) {
        smoothlyDeselectItems(in: coordinator)
    }
}
