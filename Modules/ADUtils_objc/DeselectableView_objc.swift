//
//  DeselectableView_objc.swift
//  Pods
//
//  Created by Benjamin Lavialle on 28/12/2016.
//
//

import Foundation
import UIKit

//???: (Benjamin Lavialle) 12/10/16 Protocol extension is not allowed in objc, adding thoses methods to table/collection view should be enough

extension UITableView {

    @objc public var adobjc_selectedIndexPaths: [IndexPath]? {
        return selectedIndexPaths
    }

    @objc public func adobjc_deselect(atIndexPath indexPath: IndexPath, animated: Bool) {
        deselect(atIndexPath: indexPath, animated: animated)
    }

    @objc public func adobjc_select(atIndexPath indexPath: IndexPath, animated: Bool) {
        select(atIndexPath: indexPath, animated: animated)
    }

    @objc public func adobjc_smoothlyDeselectItems(in coordinator: UIViewControllerTransitionCoordinator?) {
        smoothlyDeselectItems(in: coordinator)
    }
}

extension UICollectionView  {

    @objc public var adobjc_selectedIndexPaths: [IndexPath]? {
        return selectedIndexPaths
    }

    @objc public func adobjc_deselect(atIndexPath indexPath: IndexPath, animated: Bool) {
        deselect(atIndexPath: indexPath, animated: animated)
    }

    @objc public func adobjc_select(atIndexPath indexPath: IndexPath, animated: Bool) {
        select(atIndexPath: indexPath, animated: animated)
    }

    @objc public func adobjc_smoothlyDeselectItems(in coordinator: UIViewControllerTransitionCoordinator?) {
        smoothlyDeselectItems(in: coordinator)
    }
}
