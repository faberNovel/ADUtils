//
//  DeselectorView.swift
//  BabolatPulse
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation

/**
 * This is a protocol to factorize table and collection view selection methods
 * There is not reason those methods should be called
 */

public protocol DeselectableView: class {
    var selectedIndexPaths: [NSIndexPath]? { get }
    func deselect(atIndexPath indexPath: NSIndexPath, animated: Bool)
    func select(atIndexPath indexPath: NSIndexPath, animated: Bool)
}

public extension DeselectableView where Self: UIView {

    //MARK: - DeselectableView

    /**
    * Smootly deselects item in DeselectableView (ie Table/Collection view) along coordinator's transition
    * Should be used inside viewWillAppear :

    * override func viewWillAppear(animated: Bool) {
    *     super.viewWillAppear(animated)
    *     collectionView.smoothlyDeselectItems(withCoordinator: transitionCoordinator())
    * }

    */

    public func smoothlyDeselectItems(withCoordinator coordinator: UIViewControllerTransitionCoordinator?) {
        guard let selectedIndexPaths = selectedIndexPaths else { return }
        guard let coordinator = coordinator else {
            deselect(atIndexPaths: selectedIndexPaths, animated: false)
            return
        }

        coordinator.animateAlongsideTransitionInView(self, animation: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
            self?.deselect(atIndexPaths: selectedIndexPaths, animated: true)
        })
        { [weak self] (context : UIViewControllerTransitionCoordinatorContext) in
            guard context.isCancelled() else {
                return
            }
            self?.select(atIndexPaths: selectedIndexPaths, animated: false)
        }
    }

    //MARK: - Private

    private  func select(atIndexPaths indexPaths: [NSIndexPath], animated: Bool) {
        for indexPath in indexPaths {
            select(atIndexPath: indexPath, animated: animated)
        }
    }

    private  func deselect(atIndexPaths indexPaths: [NSIndexPath], animated: Bool) {
        for indexPath in indexPaths {
            deselect(atIndexPath: indexPath, animated: animated)
        }
    }
}

extension UITableView: DeselectableView {

    public var selectedIndexPaths: [NSIndexPath]? {
        return indexPathsForSelectedRows
    }

    public func deselect(atIndexPath indexPath: NSIndexPath, animated: Bool) {
        deselectRowAtIndexPath(indexPath, animated: animated)
    }

    public func select(atIndexPath indexPath: NSIndexPath, animated: Bool) {
        selectRowAtIndexPath(indexPath, animated: animated, scrollPosition: .None)
    }
}

extension UICollectionView: DeselectableView {

    public var selectedIndexPaths: [NSIndexPath]? {
        return indexPathsForSelectedItems()
    }

    public func deselect(atIndexPath indexPath: NSIndexPath, animated: Bool) {
        deselectItemAtIndexPath(indexPath, animated: animated)
    }

    public func select(atIndexPath indexPath: NSIndexPath, animated: Bool) {
        selectItemAtIndexPath(indexPath, animated: animated, scrollPosition: .None)
    }
}
