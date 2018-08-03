//
//  RegisterableView.swift
//  HSBC
//
//  Created by Pierre Felgines on 09/08/16.
//
//

import Foundation
import UIKit

/*
 * Usage example:
 *
 * To register a cell class :
 *    tableView.registerCell(.Class(UITableViewCell.self))
 * To register a cell nib :
 *    tableView.registerCell(.Nib(ADTableViewCell.self))
 *
 * Note that there is a handy method tableView.registerCells([]) that allow
 * to register mutiple cells at once
 *
 * To dequeue a cell use :
 *    let cell: UITableViewCell = tableView.dequeueCellAtIndexPath(indexPath)
 *
 * Same methods can be used on UITableView or UICollectionView.
 *
 */

public protocol ClassIdentifiable {
    static func identifier() -> String
}

extension NSObject : ClassIdentifiable {
    public static func identifier() -> String {
        return String(self)
    }
}

public enum RegisterableView {
    case Nib(AnyClass)
    case Class(AnyClass)
}

public extension RegisterableView {
    public var nib: UINib? {
        switch self {
        case let .Nib(cellClass): return UINib(nibName: String(cellClass), bundle: nil)
        default: return nil
        }
    }

    public var identifier: String {
        switch self {
        case let .Nib(cellClass): return cellClass.identifier()
        case let .Class(cellClass): return cellClass.identifier()
        }
    }

    public var cellClass: AnyClass? {
        switch self {
        case let .Class(cellClass): return cellClass
        default: return nil
        }
    }
}

public protocol CollectionView {
    func registerCell(cell: RegisterableView)
    func registerHeader(header: RegisterableView)
    func registerFooter(footer: RegisterableView)
}

public extension CollectionView {
    public func registerCells(cells: [RegisterableView]) {
        cells.forEach(registerCell)
    }

    public func registerHeaders(headers: [RegisterableView]) {
        headers.forEach(registerHeader)
    }

    public func registerFooters(footers: [RegisterableView]) {
        footers.forEach(registerFooter)
    }
}

extension UITableView : CollectionView {
    public func registerCell(cell: RegisterableView) {
        switch cell {
        case .Nib:
            registerNib(cell.nib, forCellReuseIdentifier: cell.identifier)
        case .Class:
            registerClass(cell.cellClass, forCellReuseIdentifier: cell.identifier)
        }
    }

    public func registerHeader(header: RegisterableView) {
        switch header {
        case .Nib:
            registerNib(header.nib, forHeaderFooterViewReuseIdentifier: header.identifier)
        case .Class:
            registerClass(header.cellClass, forHeaderFooterViewReuseIdentifier: header.identifier)
        }
    }

    public func registerFooter(footer: RegisterableView) {
        registerHeader(footer)
    }
}

extension UICollectionView : CollectionView {
    public func registerCell(cell: RegisterableView) {
        switch cell {
        case .Nib:
            registerNib(cell.nib, forCellWithReuseIdentifier: cell.identifier)
        case .Class:
            registerClass(cell.cellClass, forCellWithReuseIdentifier: cell.identifier)
        }
    }

    public func registerHeader(header: RegisterableView) {
        registerSupplementaryView(header, kind: UICollectionElementKindSectionHeader)
    }

    public func registerFooter(footer: RegisterableView) {
        registerSupplementaryView(footer, kind: UICollectionElementKindSectionFooter)
    }

    private func registerSupplementaryView(view: RegisterableView, kind: String) {
        switch view {
        case .Nib:
            registerNib(view.nib, forSupplementaryViewOfKind:kind , withReuseIdentifier: view.identifier)
        case .Class:
            registerClass(view.cellClass, forSupplementaryViewOfKind:kind , withReuseIdentifier: view.identifier)
        }
    }
}

extension UITableView {
    public func dequeueCellAtIndexPath<U: ClassIdentifiable>(indexPath: NSIndexPath) -> U {
        return dequeueReusableCellWithIdentifier(U.identifier(), forIndexPath: indexPath) as! U
    }

    public func dequeueHeader<U: ClassIdentifiable>() -> U {
        return dequeueReusableHeaderFooterViewWithIdentifier(U.identifier()) as! U
    }

    public func dequeueFooter<U: ClassIdentifiable>() -> U {
        return dequeueHeader()
    }
}

extension UICollectionView {
    public func dequeueCellAtIndexPath<U: ClassIdentifiable>(indexPath: NSIndexPath) -> U {
        return dequeueReusableCellWithReuseIdentifier(U.identifier(), forIndexPath: indexPath) as! U
    }

    public func dequeueHeaderAtIndexPath<U: ClassIdentifiable>(indexPath: NSIndexPath) -> U {
        return dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: U.identifier(), forIndexPath: indexPath) as! U
    }

    public func dequeueFooterAtIndexPath<U: ClassIdentifiable>(indexPath: NSIndexPath) -> U {
        return dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: U.identifier(), forIndexPath: indexPath) as! U
    }
}
