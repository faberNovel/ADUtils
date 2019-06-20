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
 *    tableView.register(cell: .class(UITableViewCell.self))
 * To register a cell nib :
 *    tableView.register(cell: .nib(ADTableViewCell.self))
 *
 * Note that there is a handy method tableView.register(cells: []) that allow
 * to register mutiple cells at once
 *
 * To dequeue a cell use :
 *    let cell: UITableViewCell = tableView.dequeueCellAt(indexPath: indexPath)
 *
 * Same methods can be used on UITableView or UICollectionView.
 *
 */

public protocol ClassIdentifiable {
    static func identifier() -> String
}

extension NSObject : ClassIdentifiable {
    public static func identifier() -> String {
        return String(describing: self)
    }
}

public enum RegisterableView {
    case nib(NSObject.Type)
    case `class`(NSObject.Type)
}

public extension RegisterableView {
    var nib: UINib? {
        switch self {
        case let .nib(cellClass): return UINib(nibName: String(describing: cellClass), bundle: nil)
        default: return nil
        }
    }

    var identifier: String {
        switch self {
        case let .nib(cellClass): return cellClass.identifier()
        case let .class(cellClass): return cellClass.identifier()
        }
    }

    var cellClass: AnyClass? {
        switch self {
        case let .class(cellClass): return cellClass
        default: return nil
        }
    }
}

public protocol CollectionView {
    func register(cell: RegisterableView)
    func register(header: RegisterableView)
    func register(footer: RegisterableView)
}

public extension CollectionView {
    func register(cells: [RegisterableView]) {
        cells.forEach(register(cell:))
    }

    func register(headers: [RegisterableView]) {
        headers.forEach(register(header:))
    }

    func register(footers: [RegisterableView]) {
        footers.forEach(register(footer:))
    }
}

extension UITableView : CollectionView {
    public func register(cell: RegisterableView) {
        switch cell {
        case .nib:
            register(cell.nib, forCellReuseIdentifier: cell.identifier)
        case .class:
            register(cell.cellClass, forCellReuseIdentifier: cell.identifier)
        }
    }

    public func register(header: RegisterableView) {
        switch header {
        case .nib:
            register(header.nib, forHeaderFooterViewReuseIdentifier: header.identifier)
        case .class:
            register(header.cellClass, forHeaderFooterViewReuseIdentifier: header.identifier)
        }
    }

    public func register(footer: RegisterableView) {
        register(header: footer)
    }
}

extension UICollectionView : CollectionView {
    public func register(cell: RegisterableView) {
        switch cell {
        case .nib:
            register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
        case .class:
            register(cell.cellClass, forCellWithReuseIdentifier: cell.identifier)
        }
    }

    public func register(header: RegisterableView) {
        register(supplementaryView: header, kind: UICollectionView.elementKindSectionHeader)
    }

    public func register(footer: RegisterableView) {
        register(supplementaryView: footer, kind: UICollectionView.elementKindSectionFooter)
    }

    private func register(supplementaryView view: RegisterableView, kind: String) {
        switch view {
        case .nib:
            register(view.nib, forSupplementaryViewOfKind:kind , withReuseIdentifier: view.identifier)
        case .class:
            register(view.cellClass, forSupplementaryViewOfKind:kind , withReuseIdentifier: view.identifier)
        }
    }
}

extension UITableView {
    public func dequeueCell<U: ClassIdentifiable>(_ cellClass: U.Type = U.self, at indexPath: IndexPath) -> U {
        return dequeueReusableCell(withIdentifier: U.identifier(), for: indexPath) as! U
    }

    public func dequeueHeader<U: ClassIdentifiable>(_ headerClass: U.Type = U.self) -> U {
        return dequeueReusableHeaderFooterView(withIdentifier: U.identifier()) as! U
    }

    public func dequeueFooter<U: ClassIdentifiable>(_ footerClass: U.Type = U.self) -> U {
        return dequeueHeader()
    }
}

extension UICollectionView {
    public func dequeueCell<U: ClassIdentifiable>(_ cellClass: U.Type = U.self, at indexPath: IndexPath) -> U {
        return dequeueReusableCell(withReuseIdentifier: U.identifier(), for: indexPath) as! U
    }

    public func dequeueHeader<U: ClassIdentifiable>(_ headerClass: U.Type = U.self, at indexPath: IndexPath) -> U {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: U.identifier(), for: indexPath) as! U
    }

    public func dequeueFooter<U: ClassIdentifiable>(_ footerClass: U.Type = U.self, at indexPath: IndexPath) -> U {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: U.identifier(), for: indexPath) as! U
    }
}
