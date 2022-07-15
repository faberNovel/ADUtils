//
//  UINavigationItem+BackItem.swift
//  ADUtils
//
//  Created by Gaétan Zanella on 26/03/2020.
//

import UIKit

public extension UINavigationItem {

    /**
     * Hides the back bar button item title.
     *
     * - Important: This method modifies the `backBarButtonItem` of the item.
     */
    @available(tvOS, unavailable)
    func ad_hideBackButtonTitle() {
        if #available(iOS 14.0, *) {
            backButtonDisplayMode = .minimal
        } else {
            backBarButtonItem = .empty
        }
    }
}

private extension UIBarButtonItem {

    static var empty: UIBarButtonItem {
        UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
