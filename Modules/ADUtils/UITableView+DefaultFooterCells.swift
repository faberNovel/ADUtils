//
//  UITableView+DefaultFooterCells.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 26/03/2020.
//

import UIKit

public extension UITableView {

    /**
     * Hides the emptys cells at the bottom of the table view.
     *
     * - Important: This method modifies the `tableFooterView` of the plain table view.
     */
    func ad_hideDefaultFooterCells() {
        guard style == .plain else { return }
        tableFooterView = UIView()
    }
}
